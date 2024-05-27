<script>
import DateCard from "@/components/DateCard.vue";

export default {
  name: 'DateList',
  components: {DateCard},
  props: {
    date_objects: {
      type: Array,
      required: true
    }
  }
}

</script>

<template>
  <article class="results-container">
    <DateCard v-for="date_object in date_objects" :key="date_object.id" :date_object="date_object"/>
  </article>
</template>

<style scoped>

.results-container {
  display: flex;
  flex-direction: row;
  justify-content: center;
  flex-wrap: wrap;
  gap: 20px;
  margin-top: 20px;
  width: 100%;
}

</style>