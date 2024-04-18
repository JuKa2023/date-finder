<template>
    <div>
      <h3>Welche Arten von Dates suchst du?</h3>
      <p>Umso mehr angaben du betätigst umso besser kann deine Idee auf dich zugeschnitten werden.</p>
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
  </template>
  
  <script>
  export default {
    data() {
      return {
        options: [
          { text: 'Active', img: '/img/active.png' },
          { text: 'Laid Back', img: '/img/laidback.png' },
          { text: "Doesn't Matter", img: '/img/neutral.png' }
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
  