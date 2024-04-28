<script setup>
import {onMounted, ref} from "vue";
import {get_user} from "@/authentication";

const name = ref('')

onMounted(async () => {
  console.log('Hello World, this is the Home Page')
  const user = await get_user();
  name.value = user.email
})
</script>

<template>
  <span>Hallo {{ name }}</span>
</template>

<style scoped>

</style>