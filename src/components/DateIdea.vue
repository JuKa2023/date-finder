<script setup>
import {onMounted, ref, watch} from 'vue';
import {useRoute} from 'vue-router';
import {supabase} from "@/supabase";
import {get_user} from "@/authentication";

const route = useRoute();
const id = ref(route.params.id);
const idea = ref(null);
const isLiked = ref(false);
const isSaved = ref(false);
const user = ref(null);

onMounted(async () => {
  user.value = await get_user();
  if (route.params.id) {
    updateDateIdea(route.params.id);
  }
});

watch(() => route.params.id, (newId) => {
  if (newId) {
    updateDateIdea(newId);
  }
});

async function updateDateIdea(ideaId) {
  const {data, error} = await fetchDateIdea(ideaId);
  if (error) {
    console.error(error);
    return;
  }
  idea.value = data[0];
  await checkProfileIdea(ideaId, user.value.id);
}

async function fetchDateIdea(ideaId) {
  return supabase.from('idea')
      .select()
      .eq('id', ideaId);
}

async function checkProfileIdea(ideaId, profileId) {
  const {data, error} = await supabase
      .from('profiles_ideas')
      .select()
      .eq('idea_id', ideaId)
      .eq('profile_id', profileId);

  if (error) {
    console.error(error);
    isLiked.value = false;
    isSaved.value = false;
    return;
  }

  isLiked.value = data.length > 0 ? data[0].liked : false;
  isSaved.value = data.length > 0 ? data[0].saved : false;
}

async function toggleLikeIdea() {
  isLiked.value = !isLiked.value;
  await updateProfileIdea(id.value, user.value.id, 'liked', isLiked.value);
}

async function toggleSaveIdea() {
  isSaved.value = !isSaved.value;
  await updateProfileIdea(id.value, user.value.id, 'saved', isSaved.value);
}

async function updateProfileIdea(ideaId, profileId, field, value) {
  const {data, error: selectError} = await supabase
      .from('profiles_ideas')
      .select('*')
      .eq('idea_id', ideaId)
      .eq('profile_id', profileId);

  if (selectError) {
    console.error('Error fetching profile idea:', selectError);
    return;
  }

  if (data.length > 0) {
    const {error: updateError} = await supabase
        .from('profiles_ideas')
        .update({[field]: value})
        .eq('idea_id', ideaId)
        .eq('profile_id', profileId);

    if (updateError) {
      console.error('Error updating profile idea:', updateError);
    }
  } else {
    const {error: insertError} = await supabase
        .from('profiles_ideas')
        .insert({
          idea_id: ideaId,
          profile_id: profileId,
          [field]: value
        });

    if (insertError) {
      console.error('Error inserting profile idea:', insertError);
    }
  }
}


</script>


<template>
  <div>

    <article v-if="idea" class="idea">
      <div class="date">
        <h2>{{ idea.title }}</h2>
        <p>{{ idea.description }}</p>

        <!-- <button class="shadow-button" @click="toggleLikeIdea">{{ isLiked ? 'Unlike' : 'Like' }}</button> -->
        <button class="shadow-button" @click="toggleSaveIdea">{{ isSaved ? 'Unsave' : 'Save' }}</button>
      </div>
      <div class="image">
        <img :src="idea.image" alt="Date Idea Image">
      </div>
    </article>
    <p v-else> Loading...</p>
  </div>
</template>


<style scoped>
.idea {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin: 1rem;
  padding: 1rem;
  background-color: #ffffff;
  border-radius: 4px;
  gap: 20px;

}

.date {
  width: 70%;
}

.image {
  width: 30%;
}

.image img {
  width: 100%;
}

</style>
