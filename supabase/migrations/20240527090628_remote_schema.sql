
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";

COMMENT ON SCHEMA "public" IS 'standard public schema';

CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";

CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";

CREATE OR REPLACE FUNCTION "public"."get_ideas_by_tags_json"("input_json" "jsonb") RETURNS TABLE("idea_id" bigint, "title" "text", "description" "text", "image_url" "text", "tags" "text"[])
    LANGUAGE "plpgsql"
    AS $$DECLARE
  tags_array text[];
BEGIN
  -- Extract the array of tags from the JSON input
  tags_array := ARRAY(SELECT jsonb_array_elements_text(input_json -> 'tags'));

  RETURN QUERY
  SELECT 
    i.id,
    i.title,
    i.description,
    i.image_url,
    array_agg(DISTINCT t.name)
  FROM 
    idea i
    JOIN ideas_tags it ON i.id = it.idea_id
    JOIN tag t ON it.tag_id = t.id
  WHERE 
    t.name = ANY(tags_array)
  GROUP BY 
    i.id;
END;$$;

ALTER FUNCTION "public"."get_ideas_by_tags_json"("input_json" "jsonb") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
begin
  insert into public.profiles (id, full_name, avatar_url)
  values (new.id, new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'avatar_url');
  return new;
end;
$$;

ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";

CREATE TABLE IF NOT EXISTS "public"."idea" (
    "id" bigint NOT NULL,
    "title" "text",
    "description" "text",
    "image_url" "text"
);

ALTER TABLE "public"."idea" OWNER TO "postgres";

ALTER TABLE "public"."idea" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."dateIdeas_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."ideas_tags" (
    "id" bigint NOT NULL,
    "idea_id" bigint,
    "tag_id" bigint
);

ALTER TABLE "public"."ideas_tags" OWNER TO "postgres";

COMMENT ON TABLE "public"."ideas_tags" IS 'Bridge Table (n:m)';

ALTER TABLE "public"."ideas_tags" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."ideas_tags_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "updated_at" timestamp with time zone,
    "username" "text",
    "full_name" "text",
    "avatar_url" "text",
    CONSTRAINT "username_length" CHECK (("char_length"("username") >= 3))
);

ALTER TABLE "public"."profiles" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."profiles_ideas" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "liked" boolean DEFAULT false NOT NULL,
    "saved" boolean DEFAULT false NOT NULL,
    "idea_id" bigint NOT NULL,
    "profile_id" "uuid" DEFAULT "auth"."uid"() NOT NULL
);

ALTER TABLE "public"."profiles_ideas" OWNER TO "postgres";

COMMENT ON TABLE "public"."profiles_ideas" IS 'Bridge Table (n:m)';

ALTER TABLE "public"."profiles_ideas" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."profiles_ideas_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."tag" (
    "id" bigint NOT NULL,
    "name" "text",
    "bild" "text",
    "step" smallint,
    "farbe" "text"
);

ALTER TABLE "public"."tag" OWNER TO "postgres";

ALTER TABLE "public"."tag" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."restrictions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY "public"."idea"
    ADD CONSTRAINT "dateIdeas_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."ideas_tags"
    ADD CONSTRAINT "ideas_tags_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."profiles_ideas"
    ADD CONSTRAINT "profiles_ideas_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_username_key" UNIQUE ("username");

ALTER TABLE ONLY "public"."tag"
    ADD CONSTRAINT "restrictions_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."ideas_tags"
    ADD CONSTRAINT "ideas_tags_idea_id_fkey" FOREIGN KEY ("idea_id") REFERENCES "public"."idea"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."ideas_tags"
    ADD CONSTRAINT "ideas_tags_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "public"."tag"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."profiles_ideas"
    ADD CONSTRAINT "profiles_ideas_idea_id_fkey" FOREIGN KEY ("idea_id") REFERENCES "public"."idea"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."profiles_ideas"
    ADD CONSTRAINT "profiles_ideas_profile_id_fkey" FOREIGN KEY ("profile_id") REFERENCES "public"."profiles"("id") ON UPDATE CASCADE ON DELETE CASCADE;

CREATE POLICY "Enable read access for all users" ON "public"."idea" FOR SELECT USING (true);

CREATE POLICY "Enable read access for all users" ON "public"."ideas_tags" FOR SELECT USING (true);

CREATE POLICY "Enable read access for all users" ON "public"."tag" FOR SELECT USING (true);

CREATE POLICY "Public profiles are viewable by everyone." ON "public"."profiles" FOR SELECT USING (true);

CREATE POLICY "User can view/update liked/saved" ON "public"."profiles_ideas" TO "authenticated" USING (("auth"."uid"() = "profile_id"));

CREATE POLICY "Users can insert their own profile." ON "public"."profiles" FOR INSERT WITH CHECK (("auth"."uid"() = "id"));

CREATE POLICY "Users can update own profile." ON "public"."profiles" FOR UPDATE USING (("auth"."uid"() = "id"));

ALTER TABLE "public"."idea" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."ideas_tags" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."profiles_ideas" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."tag" ENABLE ROW LEVEL SECURITY;

ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";

GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

GRANT ALL ON FUNCTION "public"."get_ideas_by_tags_json"("input_json" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."get_ideas_by_tags_json"("input_json" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_ideas_by_tags_json"("input_json" "jsonb") TO "service_role";

GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";

GRANT ALL ON TABLE "public"."idea" TO "anon";
GRANT ALL ON TABLE "public"."idea" TO "authenticated";
GRANT ALL ON TABLE "public"."idea" TO "service_role";

GRANT ALL ON SEQUENCE "public"."dateIdeas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."dateIdeas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."dateIdeas_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."ideas_tags" TO "anon";
GRANT ALL ON TABLE "public"."ideas_tags" TO "authenticated";
GRANT ALL ON TABLE "public"."ideas_tags" TO "service_role";

GRANT ALL ON SEQUENCE "public"."ideas_tags_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."ideas_tags_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."ideas_tags_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";

GRANT ALL ON TABLE "public"."profiles_ideas" TO "anon";
GRANT ALL ON TABLE "public"."profiles_ideas" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles_ideas" TO "service_role";

GRANT ALL ON SEQUENCE "public"."profiles_ideas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."profiles_ideas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."profiles_ideas_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."tag" TO "anon";
GRANT ALL ON TABLE "public"."tag" TO "authenticated";
GRANT ALL ON TABLE "public"."tag" TO "service_role";

GRANT ALL ON SEQUENCE "public"."restrictions_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."restrictions_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."restrictions_id_seq" TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";

RESET ALL;
