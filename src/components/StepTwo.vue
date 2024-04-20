<template>
    <div class="content-container">
      <h3>Was ist dein Budget?</h3>
      <p>Bitte wähle dein maximales Budget aus, den du für deine Verabredung ausgeben möchtest. Es werden dir Vorschläge angezeigt, die deinem Budget entsprechen oder günstiger sind.</p>
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
          { text: 'Kostenlos', img: '/img/active.png' },
          { text: 'Budget freundlich', img: '/img/laidback.png' },
          { text: "Luxuriös", img: '/img/neutral.png' }
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
  