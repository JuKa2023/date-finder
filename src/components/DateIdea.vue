<template>
  <div>
    <article class="idea" v-if="idea">
      <div class="date">
        <h2>{{idea.title}}</h2>
        <p>{{idea.description}}</p>
      </div>
      <div class="image">
        <img :src="idea.image" alt="Date Idea Image">
      </div>
    </article>
    <p v-else> Loading...</p>
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
.idea{
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin: 1rem;
  padding: 1rem;
  background-color: #ffffff;
  border-radius: 4px;
  gap: 20px;

}

.date{
  width: 70%;
}

.image{
  width: 30%;
}

.image img{
  width: 100%;
}

</style>
