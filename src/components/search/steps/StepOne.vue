<template>
  <div class="content-container">
    <h2>Welche Arten von Dates suchst du?</h2>
    <p>Umso mehr Angaben du bestätigst, umso besser kann deine Idee auf dich zugeschnitten werden.</p>
    <article class="options-container">
      <div v-for="option in options" :key="option.text" @click="selectOption(option)" class="cardClickable">
        <div class="top">
          <div>
            <h3 class="activity">{{ option.text }}</h3>
          </div>
          <img class="Bildcard" :src="option.img" :alt="`illustration of ${option.text}`">
        </div>
        <div class="farbbox">
          <img class="logo" src="/img/logo_datefinderr.svg" alt="logo related to the activity">
        </div>
        </div>
    </article>
    <button @click="selectOption({text: 'spielt keine Rolle'})" class="shadow-button">spielt keine Rolle</button>
  </div>
</template>

<script setup>
import {ref, defineEmits} from 'vue';

const emits = defineEmits(['step-complete']);

const options = ref([
  {text: 'aktiv', img: '/img/active.png'},
  {text: 'locker', img: '/img/laidback.png'},
]);

function selectOption(option) {
  if (option.text === 'spielt keine Rolle') {
    for (let i = 0; i < options.value.length; i++) {
      emits('step-complete', options.value[i]);
    }
    return;
  }
  emits('step-complete', option);
}
</script>

<style scoped>


</style>