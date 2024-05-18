<script setup>
import {supabase} from '@/supabase'
import {onMounted, ref, watchEffect} from 'vue'
import {get_user} from "@/authentication";

import DateList from "@/components/search/DateList.vue";

const loading = ref(true)

const email = ref('')
const username = ref('')
const firstName = ref('')
const avatar_url = ref('')
const password = ref('')
const restrictions = ref('')

const isModified = ref(false);

const savedIdeas = ref([])
const likedIdeas = ref([])

onMounted(async () => {
  await getProfile()
})


async function updateSavedLikedIdeas(userId) {
  const {data, error} = await supabase
      .from('profiles_ideas')
      .select(`
                idea_id,
                liked,
                saved,
                idea (*)
            `)
      .eq('profile_id', userId);

  if (error) throw error;

  savedIdeas.value = data.filter(item => item.saved).map(item => item.idea);
  likedIdeas.value = data.filter(item => item.liked).map(item => item.idea);
  console.log("savedIdeas ref")
}

async function getProfile() {
  try {
    const user = await get_user();

    const {data, error, status} = await supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single()

    if (error && status !== 406) throw error

    if (data) {
      email.value = user.email
      firstName.value = data.full_name
      username.value = data.username
      avatar_url.value = data.avatar_url
    }

    await updateSavedLikedIdeas(user.id)
  } catch (error) {
    alert(error.message)
  } finally {
    loading.value = false
  }
}

async function updateProfile() {
  try {
    loading.value = true
    const user = await get_user();

    const updates = {
      id: user.id,
      username: username.value,
      full_name: firstName.value,
      avatar_url: avatar_url.value,
      updated_at: new Date()
    }

    const {error} = await supabase.from('profiles').upsert(updates)

    if (error) throw error
  } catch (error) {
    alert(error.message)
  } finally {
    loading.value = false
  }
}

//detect changes and enable Button

watchEffect(() => {
  isModified.value = email.value !== '' || username.value !== '' || firstName.value !== '' || password.value !== '' || restrictions.value !== '';
});

function handleChange() {
  isModified.value = true;
}

</script>

<template>
  <article class="format">
    <h1>Konto-Einstellungen</h1>
    <div class="formatKonto">
      <form class="form-widget" @submit.prevent="updateProfile">
        <div class="field">
          <label class="label" for="email">E-Mail:</label>
          <input id="email" v-model="email" class="input" disabled type="email" @input="handleChange"/>
        </div>

        <div class="field">
          <label class="label" for="username">Benutzername:</label>
          <input id="username" v-model="username" class="input" type="text" @input="handleChange"/>
        </div>

        <div class="field">
          <label class="label" for="vorname">Vorname:</label>
          <input id="firstName" v-model="firstName" class="input" type="text" @input="handleChange"/>
        </div>

        <div class="field">
          <label class="label" for="password">Passwort:</label>
          <input id="password" v-model="password" class="input" type="password" @input="handleChange"/>
        </div>

        <div class="field">
          <label class="label" for="restrictions">Einschränkungen:</label>
          <input id="restrictions" v-model="restrictions" class="input" type="text" @input="handleChange"/>
        </div>

        <div class="field">
          <button v-if="isModified" :disabled="loading" class="button primary " type="submit">
            {{ loading ? 'Aktualisieren...' : 'Profil aktualisieren' }}
          </button>
        </div>
      </form>
      <img src="/img/platzhalter.png">
    </div>

    <section class="format">
      <h2>Gespeicherte Ideen</h2>
      <DateList :date_objects="savedIdeas"/>
    </section>

  </article>
</template>


<style scoped>
.format {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-top: 20px;
}

.form-widget {
  width: 100%;
  margin: 0 auto;
  padding: 20px;
  border-radius: 4px;
}

.form-widget div.field {
  display: flex; /* Use flexbox */
  align-items: center; /* Align items vertically in the center */
  margin-bottom: 10px;
}

.formatKonto {
  display: flex;
  flex-direction: row;
  justify-content: space-evenly;
  gap: 20px;
  width: 100%;
}

.label {
  width: 150px;
  font-family: 'Roboto', sans-serif;
  color: #211230;
  font-size: 18px;
  margin-right: 10px;
}

.input {
  flex-grow: 1;
  padding: 10px;
  background-color: transparent;
  border: none;
  border-radius: 4px;
  color: #211230;
  font-size: 18px;
}

.input:focus {
  background-color: #ffffff;
  border-color: #D77F8F
}

</style>