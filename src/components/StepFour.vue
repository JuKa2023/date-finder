<template>
    <div>
      <h3>Wann würdest du gerne auf ein Date gehen?</h3>
      <p>Beachte dabei, dass bestimmte Aktivitäten nicht immer durchgeführt werden können. Ideen, die immer umgesetzt werden können, werden durch deine Auswahl nicht eingeschränkt.</p>
      <div class="options-container">
        <article v-for="option in options" :key="option.text" @click="selectOption(option)" class="cardNotClick">
          <section>
            <div>
              <h2 class="activity">{{ option.text }}</h2>
            </div>
            <img class="Bildcard" :src="option.img" :alt="`illustration of ${option.text}`">
            <img class="logo" src="/img/logo_datefinderr.svg" alt="logo related to the activity">
          </section>
        </article>
      </div>
      <button @click="selectOption({text:'spielt keine Rolle'})" class="shadow-button">spielt keine Rolle</button>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        options: [
          { text: 'Morgen', img: '/img/active.png' },
          { text: 'Nachmittag', img: '/img/laidback.png' },
          { text: 'Abend', img: '/img/neutral.png' },
          { text: 'Nacht', img: '/img/neutral.png' }
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
  