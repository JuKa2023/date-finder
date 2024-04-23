<script setup>
import { ref, computed } from 'vue';
import { defineProps, defineEmits } from 'vue';

const props = defineProps({
  steps: Array  // Expected format: [{ name: String, component: Component, path: String }]
});

const emits = defineEmits(['all-search-complete']);

const currentStep = ref(0);
const results = ref([]);

const progressBarWidth = computed(() => {
  return ((currentStep.value + 1) / props.steps.length * 100) + '%';
});

const currentComponent = computed(() => {
  return props.steps[currentStep.value].component;
});

function nextStep(data) {
  results.value.push(data);
  if (currentStep.value < props.steps.length - 1) {
    currentStep.value++;
  } else {
    console.log('All search complete', results.value);
    emits('all-steps-complete', results.value);
  }
}

function handleStepComplete(data) {
  nextStep(data);
}
</script>

<template>
  <div class="format">
    <div class="progress-bar-container">
      <div class="progress-bar" :style="{ width: progressBarWidth }"></div>
    </div>

    <component :is="currentComponent" @step-complete="handleStepComplete"/>
  </div>
</template>

<style scoped>
.progress-bar-container {
  width: 100%;
  height: 20px;
  background-color: #ffffff;
  border-radius: 10px;
  margin-bottom: 10px;
}

.progress-bar {
  height: 100%;
  background-color: #405983;
  border-radius: 10px;
  transition: width 0.3s ease-in-out;
}
</style>