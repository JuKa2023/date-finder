<template>
    <div>
      <h3>Was ist dein Budget?</h3>
      <p>Bitte wähle dein maximales Budget aus, den du für deine Verabredung ausgeben möchtest.Es werden dir Vorschläge angezeigt, die deinem Budget entsprechen oder günstiger sind.</p>
      <article v-for="option in options" :key="option.text" @click="selectOption(option)" class="cardNotClick">
        <section>
          <div>
            <h2 class="activity">{{ option.text }}</h2>
          </div>
          <img class="Bildcard" :src="option.img" :alt="`illustration of ${option.text}`">
          <img class="logo" src="/img/Platzhalter.png" alt="logo related to the pricing option">
        </section>
      </article>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        options: [
          { text: 'Budgetfriendly', img: '/img/budgetfriendly.png' },
          { text: 'Kostenlos', img: '/img/kostenlos.png' },
          { text: 'Luxuriös', img: '/img/luxurious.png' }
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
  