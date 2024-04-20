<template>
    <div>
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
      <button @click="selectOption({text:'spielt keine Rolle'})" class="shadow-button">spielt keine Rolle</button>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        options: [
          { text: 'Drinnen', img: '/img/active.png' },
          { text: 'Draussen', img: '/img/laidback.png' },
        ]
      };
    },
    methods: {
      selectOption(option) {
        this.$emit('step-complete'); // Optionally pass option data
      }
    }
  }
  </script>
  
  <style scoped>
  /* Your CSS here or in the global stylesheet */
  </style>
  