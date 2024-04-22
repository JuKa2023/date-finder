<template>
  <div>
    <h2>Step 1: Persönliche Informationen</h2>
    <form @submit.prevent="$emit('next')">
      <input type="text" placeholder="Vorname" v-model="personalInfo.firstName" required>
      <input type="email" placeholder="Email" v-model="personalInfo.email" required>
      <input type="text" placeholder="Username" v-model="personalInfo.username" required>
      <button type="submit">Weiter</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      personalInfo: {
        firstName: '',
        email: '',
        username: ''
      }
    };
  },
  methods: {
    nextStep() {
      this.$emit('next', this.personalInfo);
    }
  }
};
</script>
