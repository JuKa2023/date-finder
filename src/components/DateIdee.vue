<template>
  <article class="results-container">
    <section v-for="result in results" :key="result.id" class="cardNotClick">
      <div>
        <h2 class="activity">{{ result.title }}</h2>
        <p>{{ result.description }}</p>
      </div>
      <img :src="result.imageUrl" alt="illustration der Aktivität">
      <div class="chips">
        <div v-for="tag in result.tags" :key="tag" class="chip">
          <span>{{ tag }}</span>
        </div>
      </div>
    </section>
  </article>
</template>

<script>

</script>

<style scoped>
.results-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  gap: 20px;
}

.cardNotClick {
  background-color: #fefafd;
  padding: 10px 20px;
  font-family: 'Poppins Bold', sans-serif;
  width: calc(25% - 20px); /* Adjusted for responsive grid */
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(33, 18, 48, 0.2);
  margin-bottom: 20px;
  box-sizing: border-box;
}

.chips {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  margin-top: 10px;
}

.chip {
  display: inline-block;
  padding: 0 25px;
  height: 40px;
  font-size: 16px;
  line-height: 40px;
  border: #7A798C 1px solid;
  border-radius: 25px;
  background-color: #ffffff;
  margin: 5px;
  cursor: pointer; /* Changed to pointer to indicate clickability */
  color: #7A798C;
}

.activity {
  margin-bottom: 0px;
}

/* Ensure the images are responsive and do not overflow their containers */
img {
  max-width: 100%;
  height: auto;
  border-radius: 10px; /* Optional: if you want rounded corners on images */
}
</style>
