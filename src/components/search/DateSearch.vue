<script setup>

import MultiStep from "@/components/MultiStep.vue";

import StepOne from "@/components/search/steps/StepOne.vue";
import StepTwo from "@/components/search/steps/StepTwo.vue";
import StepThree from "@/components/search/steps/StepThree.vue";
import StepFour from "@/components/search/steps/StepFour.vue";
import StepFive from "@/components/search/steps/StepFive.vue";
import {ref} from "vue";
import {supabase} from "@/supabase";
import DateList from "@/components/search/DateList.vue";

const registerSteps = [
  {name: 'StepOne', path: '@/components/search', component: StepOne},
  {name: 'StepTwo', path: '@/components/search', component: StepTwo},
  {name: 'StepThree', path: '@/components/search', component: StepThree},
  {name: 'StepFour', path: '@/components/search', component: StepFour},
  {name: 'StepFive', path: '@/components/search', component: StepFive}
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

  // TODO: Remove ugly hack
  ideas.data.forEach((idea) => {
    idea.id = idea.idea_id;
    delete idea.idea_id;
  });

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
  <button v-if="isComplete"
          @click="clearSearch">Clear Search
  </button>

  <MultiStep v-if="!isComplete" :steps="registerSteps" @all-steps-complete="handleFilterComplete"/>

  <main v-else class="format">
    <h1>Das sind die Top auswahlen für dein Date</h1>
    <p>Die Resultate werden basierend auf deinem Input und deinen Interessen sortiert, wobei das am besten passende
      zuerst angezeigt wird. Es werden nur Ergebnisse angezeigt, die du noch nicht durchgeführt hast.</p>

    <section class="chips">
      <div v-for="restriction in searchTags" :key="restriction.id" class="chip"
           @click="removeRestriction(restriction.id)">
        <span>{{ restriction }}</span>
      </div>
    </section>
    
    <DateList :date_objects="results"/>
  </main>
</template>

<style scoped>

.format {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
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
  margin: 2px;
  color: #7A798C;
}

</style>