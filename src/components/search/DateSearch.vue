<script setup>

import MultiStep from "@/components/MultiStep.vue";
import DateIdeen from "@/components/DateIdeen.vue";

import StepOne from "@/components/search/steps/StepOne.vue";
import StepTwo from "@/components/search/steps/StepTwo.vue";
import StepThree from "@/components/search/steps/StepThree.vue";
import StepFour from "@/components/search/steps/StepFour.vue";
import StepFive from "@/components/search/steps/StepFive.vue";
import {ref} from "vue";

const registerSteps = [
  { name: 'StepOne', path: '@/components/search', component: StepOne},
  { name: 'StepTwo', path: '@/components/search', component: StepTwo },
  { name: 'StepThree', path: '@/components/search', component: StepThree },
  { name: 'StepFour', path: '@/components/search', component: StepFour },
  { name: 'StepFive', path: '@/components/search', component: StepFive }
];

//const isComplete = ref(false); // TODO: change back to false
const isComplete = ref(true);

function handleFilterComplete(results) {
  console.log('All search complete', results);
  isComplete.value = true;
}

</script>

<template>
  <MultiStep :steps="registerSteps" @all-steps-complete="handleFilterComplete" v-if="!isComplete"/>
  <DateIdeen v-else></DateIdeen>
</template>

<style scoped>

</style>