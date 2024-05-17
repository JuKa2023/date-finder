<script>
export default {
  props: {
    date_object: {
      type: Object,
      required: true
    }
  }
}

</script>

<template>
  <RouterLink :to="{name: 'idea', params: {id: date_object.idea_id}}">
    <div class="flexInCard">
      <h3 class="activity">{{ date_object.title }}</h3>
      <p>{{ date_object.description }}</p>
    </div>
    <img :src="date_object.imageUrl" alt="illustration der Aktivität">
    <div class="chips">
      <div v-for="tag in date_object.tags" :key="tag" class="chip">
        <span>{{ tag }}</span>
      </div>
    </div>
  </RouterLink>
</template>

<style>
.flexInCard {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.chips {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  margin-top: 10px;
}

.chip {
  padding: 0 10px;
  font-size: 14px;
  line-height: 30px;
  border: #7A798C 1px solid;
  border-radius: 25px;
  background-color: #ffffff;
  margin: 2px;
  color: #7A798C;
}

.activity {
  margin-bottom: 0;
}

img {
  max-width: 100%;
  height: auto;
  border-radius: 10px;
}
</style>