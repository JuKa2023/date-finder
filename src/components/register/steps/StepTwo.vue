<template>
  <div>
    <h2>Step 2: Einschränkungen</h2>
    <button @click="$emit('next', true)">Ja</button>
    <button @click="$emit('next', false)">Nein</button>
  </div>
</template>

<script>
export default {
  methods: {
    answer(hasLimitations) {
      this.$emit('next', hasLimitations);
    }
  }
};
</script>
