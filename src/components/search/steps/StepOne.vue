<template>
  <div class="content-container">
    <h2>Welche Arten von Dates suchst du?</h2>
    <p>Umso mehr Angaben du bestätigst, umso besser kann deine Idee auf dich zugeschnitten werden.</p>
    <article class="options-container">
      <div v-for="option in options" :key="option.text" @click="selectOption(option)" class="cardClickable">
        <section>
          <div>
            <h3 class="activity">{{ option.text }}</h3>
          </div>
          <img class="Bildcard" :src="option.img" :alt="`illustration of ${option.text}`">
          <img class="logo" src="/img/logo_datefinderr.svg" alt="logo related to the activity">
        </section>
      </div>
    </article>
    <button @click="selectOption({text: 'spielt keine Rolle'})" class="shadow-button">spielt keine Rolle</button>
  </div>
</template>

<script setup>
import { ref, defineEmits } from 'vue';

const emits = defineEmits(['step-complete']);

const options = ref([
  { text: 'Active', img: '/img/active.png'},
  { text: 'Laid Back', img: '/img/laidback.png'},
]);

function selectOption(option) {
  emits('step-complete', option);
}
</script>

<style scoped>


</style>