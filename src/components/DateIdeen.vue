<template>
  <article class="format">
    <h1>Das sind die Top auswahlen für dein Date</h1>
    <p>Die Resultate werden basierend auf deinem Input und deinen Interessen sortiert, wobei das am besten passende zuerst angezeigt wird. Es werden nur Ergebnisse angezeigt, die du noch nicht durchgeführt hast.</p>
    <section class="chips">
      <chip class="chip" v-for="restriction in restrictions" :key="restriction.id" @click="removeRestriction(restriction.id)">

      </chip>
    </section>
    <article class="results-container">
      <section v-for="result in results" :key="result.id" class="cardNotClick">
        <div class="flexInCard">
          <h3 class="activity">{{ result.title }}</h3>
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
  </article>
</template>

<script setup>
import { ref } from 'vue';

const results = ref([
  {
    id: 1,
    title: 'Kino',
    description: 'Schau dir einen Film in einem Kino in deiner Nähe an.',
    imageUrl: 'https://via.placeholder.com/300',
    tags: ['Film', 'Kino', 'Unterhaltung'],
  },
  {
    id: 2,
    title: 'Picknick im Park',
    description: 'Genieße ein romantisches Picknick im Park.',
    imageUrl: 'https://via.placeholder.com/300',
    tags: ['Picknick', 'Natur', 'Romantisch'],
  },
  {
    id: 3,
    title: 'Kochkurs',
    description: 'Lerne gemeinsam ein neues Gericht in einem Kochkurs.',
    imageUrl: 'https://via.placeholder.com/300',
    tags: ['Kochen', 'Kochkurs', 'Gemeinsam'],
  },
]);

</script>

<style scoped>
.results-container {
  display: flex;
  flex-direction: row;
  justify-content: center;
  width: 100%;
}

.cardNotClick {
  background-color: #fefafd;
  padding: 10px 20px;
  margin: 20px;
  font-family: 'poppins bold', sans-serif;
  width: 30%;

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

.flexInCard{
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
  margin: 2px; /* Changed to pointer to indicate clickability */
  color: #7A798C;
}

.activity {
  margin-bottom: 0;
}

/* Ensure the images are responsive and do not overflow their containers */
img {
  max-width: 100%;
  height: auto;
  border-radius: 10px; /* Optional: if you want rounded corners on images */
}
</style>
