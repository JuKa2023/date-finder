<script setup>
import {onMounted, ref} from "vue";
import {get_user} from "@/authentication";
import {supabase} from "@/supabase";

const name = ref('')

onMounted(async () => {
  console.log('Hello World, this is the Home Page')
  const user = await get_user();
  name.value = user.email

  const tagsJson = {
    tags: ['aktiv']
  };

  const { data, error } = await supabase
      .rpc('get_ideas_by_tags_json', { input_json: tagsJson });

  if (error) {
    console.error('Error fetching ideas:', error);
  } else {
    console.log('Ideas:', data);
  }


})
</script>

<template>
  <span>Hallo {{ name }}</span>
</template>

<style scoped>




</style>