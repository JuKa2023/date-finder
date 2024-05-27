<script>

export default {
  name: 'DateCard',
  props: {
    date_object: {
      type: Object,
      required: true
    }
  },
  computed: {
    imageUrl() {
      const baseURL = '/img/dates/';
      const url = baseURL + this.date_object.id + '.webp';

      console.log(url);
      return url;
    }
  }
}


</script>

<template>

  <span class="cardNotClick">
    <RouterLink :to="{name: 'idea', params: {id: date_object.id}}">
      <div class="flexInCard">
        <h3 class="activity">{{ date_object.title }}</h3>
        <img :src="imageUrl" alt="illustration der Aktivität">
      </div>

      <div class="chips">
        <div v-for="tag in date_object.tags" :key="tag" class="chip">
          <span>{{ tag }}</span>
        </div>
      </div>
    </RouterLink>
  </span>


</template>

<style>


.cardNotClick {
  background-color: #fefafd;
  padding: 10px 20px;
  font-family: 'poppins bold', sans-serif;
  width: calc(33% - 60px);

  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;

  border-radius: 4px;
  box-shadow: 0 4px 8px 0 rgba(33, 18, 48, 1);
  cursor: pointer;
}

.cardNotClick:hover {
  transform: scale(1.05);
}

.flexInCard {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 5px;
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
  hyphens: auto;
}

img {
  max-width: 100%;
  height: auto;
}
</style>