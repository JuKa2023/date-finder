<template>
  <div>
    <h1>Date Idea with id: {{ id }}</h1>
    <p>{{ idea }}</p>
  </div>
</template>

<script setup>
import {ref, watch} from 'vue'
import { useRoute } from 'vue-router'
import {supabase} from "@/supabase";

const route = useRoute()

const id = ref(route.params.id)
const idea = ref(null)

watch(() => route.params.id, (newId, oldId) => {
  id.value = newId
  fetchDateIdea(newId).then((data) => {
    if (data.error) {
      console.error(data.error)
      return null
    }
    idea.value = data.data[0]
  })
})


async function fetchDateIdea(id) {
  return supabase
      .from('idea')
      .select()
      .eq('id', id);
}

function updateDateIdea() {
  fetchDateIdea(id.value).then((data) => {
    if (data.error) {
      console.error(data.error)
      return null
    }
    idea.value = data.data[0]
  })
}

updateDateIdea()
</script>

<style scoped>

</style>
