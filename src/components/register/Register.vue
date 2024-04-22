<script setup>

import MultiStep from "@/components/MultiStep.vue";

import StepOne from "@/components/register/steps/StepOne.vue";
import StepTwo from "@/components/register/steps/StepTwo.vue";
import StepThree from "@/components/register/steps/StepThree.vue";
import StepFour from "@/components/register/steps/StepFour.vue";
import {ref} from "vue";

const registerSteps = [
  { name: 'StepOne', path: '@/components/steps', component: StepOne},
  { name: 'StepTwo', path: '@/components/steps', component: StepTwo },
  { name: 'StepThree', path: '@/components/steps', component: StepThree },
  { name: 'StepFour', path: '@/components/steps', component: StepFour },
];

const isComplete = ref(false);

function handleFilterComplete(results) {
  console.log('All search complete', results);
  isComplete.value = true;
}

</script>

<template>
  <MultiStep :steps="registerSteps" @all-steps-complete="handleFilterComplete" v-if="!isComplete"/>
</template>

<style scoped>

</style>