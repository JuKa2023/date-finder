<script setup>

import MultiStep from "@/components/MultiStep.vue";

import StepOne from "@/components/search/steps/StepOne.vue";
import StepTwo from "@/components/search/steps/StepTwo.vue";
import StepThree from "@/components/search/steps/StepThree.vue";
import StepFour from "@/components/search/steps/StepFour.vue";
import StepFive from "@/components/search/steps/StepFive.vue";
import {ref} from "vue";
import {supabase} from "@/supabase";

const registerSteps = [
  { name: 'StepOne', path: '@/components/search', component: StepOne},
  { name: 'StepTwo', path: '@/components/search', component: StepTwo },
  { name: 'StepThree', path: '@/components/search', component: StepThree },
  { name: 'StepFour', path: '@/components/search', component: StepFour },
  { name: 'StepFive', path: '@/components/search', component: StepFive }
];

const isComplete = ref(false);
const SEARCH_CACHE_KEY = 'tagsJson';
let searchTags = null;

const results = ref([])
const restrictions = ref([])

function getCachedSearch() {
  const tagsJson = localStorage.getItem(SEARCH_CACHE_KEY);
  if (tagsJson) {
    isComplete.value = true;
  }

  searchTags = JSON.parse(tagsJson);
  updateSearchResults()
}

function saveSearch(tagsJson) {
  localStorage.setItem(SEARCH_CACHE_KEY, JSON.stringify(tagsJson));
}

function clearSearch() {
  localStorage.removeItem(SEARCH_CACHE_KEY);
  isComplete.value = false;
}

async function getIdeasByTags(selectedOptions) {
  const inputJsonArgument = {
    tags: selectedOptions
  }
  return supabase.rpc('get_ideas_by_tags_json', {input_json: inputJsonArgument});
}

async function getAllTags() {
  return supabase.from('tag').select();
}

function handleFilterComplete(results) {
  isComplete.value = true;

  const selectedOptions = Array.from(results.results);
  saveSearch(selectedOptions);
  updateSearchResults();
}

async function updateSearchResults() {
  const ideas = await getIdeasByTags(searchTags);
  if (ideas.error) {
    console.error(ideas.error);
    return;
  }
  console.log(ideas.data);
  results.value = ideas.data;
}

function removeRestriction(id) {
  searchTags = searchTags.filter((tag) => tag.id !== id);
  saveSearch(searchTags);
  updateSearchResults();
}

getAllTags().then((data) => {
  if (data.error) {
    console.error(data.error);
    return null;
  }
  restrictions.value = data.data;
});

getCachedSearch();


</script>

<template>
  <button @click="clearSearch"
          v-if="isComplete">Clear Search</button>

  <MultiStep :steps="registerSteps" @all-steps-complete="handleFilterComplete" v-if="!isComplete"/>

  <main class="format" v-else>
    <h1>Das sind die Top auswahlen für dein Date</h1>
    <p>Die Resultate werden basierend auf deinem Input und deinen Interessen sortiert, wobei das am besten passende zuerst angezeigt wird. Es werden nur Ergebnisse angezeigt, die du noch nicht durchgeführt hast.</p>

    <section class="chips">
      <div class="chip" v-for="restriction in searchTags" :key="restriction.id" @click="removeRestriction(restriction.id)">
        <span>{{ restriction }}</span>
      </div>
    </section>

    <article class="results-container">
      <section v-for="result in results" :key="result.id" class="cardNotClick">
        <RouterLink :to="{name: 'idea', params: {id: result.idea_id}}">
          <div class="flexInCard">
            <h3 class="activity">{{ result.title }}</h3>
            <p>{{ result.description }}</p>
          </div>
          <img :src="result.imageUrl" alt="illustration der Aktivität">
          <div class="chips">
            <div v-for="tag in result.tags" :key="tag" class="chip">
              <span>{{ tag }}</span>
            </div>
          </div>
        </RouterLink>
      </section>
    </article>
  </main>
</template>

<style scoped>
.format{
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.results-container {
  display: flex;
  flex-direction: row;
  justify-content: center;
  flex-wrap: wrap;
  gap: 20px;
  margin-top: 20px;
  width: 100%;
}

.cardNotClick {
  background-color: #fefafd;
  padding: 10px 20px;
  font-family: 'poppins bold', sans-serif;
  width: calc(33% - 40px);

  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;

  border-radius: 4px;
  box-shadow: 0 4px 8px 0 rgba(33, 18, 48, 1);
  cursor: pointer;
}


.cardNotClick:hover {
  transform: scale(1.05);
}

.flexInCard{
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.chips {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  margin-top: 10px;
}

.chip {
  padding: 0 10px;
  font-size: 14px;
  line-height: 30px;
  border: #7A798C 1px solid;
  border-radius: 25px;
  background-color: #ffffff;
  margin: 2px; /* Changed to pointer to indicate clickability */
  color: #7A798C;
}

.activity {
  margin-bottom: 0;
}

/* Ensure the images are responsive and do not overflow their containers */
img {
  max-width: 100%;
  height: auto;
  border-radius: 10px; /* Optional: if you want rounded corners on images */
}
</style>