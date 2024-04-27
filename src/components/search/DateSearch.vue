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

const isComplete = ref(false);

// Function to handle the completion of the filter (gather all selected options)
function handleFilterComplete(results) {
  isComplete.value = true;
  const selectedOptions = Array.from(results.results); // Gather all selected options as an array
  console.log(selectedOptions);
}

</script>

<template>
  <MultiStep :steps="registerSteps" @all-steps-complete="handleFilterComplete" v-if="!isComplete"/>
  <DateIdeen v-else></DateIdeen>
</template>

<style scoped>

</style>