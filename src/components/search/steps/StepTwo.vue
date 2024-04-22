<template>
  <div class="content-container">
    <h2>Was ist dein Budget?</h2>
    <p>Bitte wähle dein maximales Budget aus, den du für deine Verabredung ausgeben möchtest. Es werden dir Vorschläge angezeigt, die deinem Budget entsprechen oder günstiger sind.</p>
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
    <button @click="selectOption({text:'spielt keine Rolle'})" class="shadow-button">spielt keine Rolle</button>
  </div>
</template>

<script setup>
import { ref, defineEmits } from 'vue';

const options = ref([
  { text: 'Kostenlos', img: '/img/active.png' },
  { text: 'Budget freundlich', img: '/img/laidback.png' },
  { text: "Luxuriös", img: '/img/neutral.png' }
]);

const emits = defineEmits(['step-complete']);

function selectOption(option) {
  emits('step-complete', option);
}
</script>

<style scoped>

</style>
