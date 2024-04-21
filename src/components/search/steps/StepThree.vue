<template>
  <div class="content-container">
    <h3>Wo würdest du gerne dein Date ausführen?</h3>
    <p>Bitte beachte die Witterungsverhältnisse zum Zeitpunkt der Durchführung und wählen den Standort entsprechend aus.</p>
    <article class="options-container">
      <div v-for="option in options" :key="option.text" @click="selectOption(option)" class="cardNotClick">
        <section>
          <div>
            <h2 class="activity">{{ option.text }}</h2>
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

const options = ref([
  { text: 'Drinnen', img: '/img/active.png' },
  { text: 'Draussen', img: '/img/laidback.png' },
]);

const emits = defineEmits(['step-complete']);

function selectOption(option) {
  emits('step-complete', option);
}
</script>

<style scoped>
/* Style as needed */
.options-container {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.cardNotClick {
  cursor: pointer;
  transition: transform 0.3s ease;
}

.cardNotClick:hover {
  transform: scale(1.05);
}

.shadow-button {
  margin-top: 20px;
  padding: 10px 20px;
  background-color: #405983;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}
</style>
