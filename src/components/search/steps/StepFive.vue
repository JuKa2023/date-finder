<template>
    <div class="content-container">
      <h2>Wie viel Zeit hast du für dein Date?</h2>
      <p>Beachte dabei, dass bestimmte Aktivitäten nicht immer durchgeführt werden können. Ideen, die immer umgesetzt werden können, werden durch deine Auswahl nicht eingeschränkt.</p>
      <article class="options-container">
        <div v-for="option in options" :key="option.text" @click="selectOption(option)" class="cardClickable">
          <div class="top">
            <div>
              <h3 class="activity">{{ option.text }}</h3>
            </div>
            <img class="Bildcard" :src="option.img" :alt="`illustration of ${option.text}`">
          </div>
          <div class="farbbox" :style="{ backgroundColor: option.color }">
            <img class="logo" src="/img/logo_datefinderr.svg" alt="logo related to the activity">
          </div>
        </div>
      </article>
      <button @click="selectOption({text:'spielt keine Rolle'})" class="shadow-button">egal</button>
    </div>
  </template>

<script setup>
import {ref, defineEmits} from 'vue';

const emits = defineEmits(['step-complete']);

const options = ref([
  { text: 'paar Stunden', img: '/img/active.png', color: '#A2D5AB'},
  { text: 'halber Tag', img: '/img/laidback.png', color: '#F9F1C2'},
  { text: 'ganzer Tag', img: '/img/neutral.png', color: '#5E376D'},
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
</script><form data-v-6d0444a6 class="form-widget">…</form>