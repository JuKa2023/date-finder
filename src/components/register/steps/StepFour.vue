<template>
  <div>
    <h2>Step 4: Interessen</h2>
    <form @submit.prevent="$emit('finish')">
      <label>
        <input type="checkbox" v-model="interests.active"> Aktiv
      </label>
      <label>
        <input type="checkbox" v-model="interests.outdoor"> Draußen
      </label>
      <!-- Add more interests as needed -->
      <button type="submit">Abschließen</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      interests: {
        active: false,
        outdoor: false
        // Add more interests as necessary
      }
    };
  }
};
</script>
