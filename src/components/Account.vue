<script setup>
import {supabase} from '@/supabase'
import {onMounted, ref} from 'vue'
import {get_user} from "@/authentication";

const loading = ref(true)

const email = ref('')
const username = ref('')
const firstName = ref('')
const avatar_url = ref('')
const password = ref('')
const restrictions = ref('')

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
                idea (
                    id,
                    title,
                    description,
                    image_url
                )
            `)
      .eq('profile_id', userId);

  if (error) throw error;
  savedIdeas.value = data.filter(item => item.saved);
  likedIdeas.value = data.filter(item => item.liked);
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
</script>

<template>
  <article class="format">
    <h1>Konto-Einstellungen</h1>
    <form class="form-widget" @submit.prevent="updateProfile">
      <div class="field">
        <label class="label" for="email">E-Mail</label>
        <input id="email" v-model="email" class="input" disabled type="email"/>
      </div>

      <div class="field">
        <label class="label" for="username">Benutzername</label>
        <input id="username" v-model="username" class="input" type="text"/>
      </div>

      <div class="field">
        <label class="label" for="vorname">Vorname</label>
        <input id="firstName" v-model="firstName" class="input" type="text"/>
      </div>

      <div class="field">
        <label class="label" for="password">Passwort</label>
        <input id="password" v-model="password" class="input" type="password"/>
      </div>

      <div class="field">
        <label class="label" for="restrictions">Einschränkungen</label>
        <input id="restrictions" v-model="restrictions" class="input" type="text"/>
      </div>

      <div class="field">
        <button :disabled="loading" class="button primary" type="submit">
          {{ loading ? 'Aktualisieren...' : 'Profil aktualisieren' }}
        </button>
      </div>
    </form>

    <section>
      <h2>Gemochte Ideen</h2>
      <ul>
        <li v-for="item in likedIdeas" :key="item.idea_id">
          <strong>{{ item.idea.title }}</strong> - {{ item.idea.description }}
        </li>
      </ul>
    </section>

    <section>
      <h2>Gespeicherte Ideen</h2>
      <ul>
        <li v-for="item in savedIdeas" :key="item.idea_id">
          <strong>{{ item.idea.title }}</strong> - {{ item.idea.description }}
        </li>
      </ul>
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

.form-widget div {
  margin-bottom: 10px;
}

.flex {
  display: flex;
  flex-direction: row;
  justify-content: space-evenly;
}

.label {
  font-family: 'Roboto', sans-serif;
  color: #211230;
  font-size: 18px;
  margin-bottom: 5px;
  margin-right: 10px;
}

.input {
  width: 100%;
  padding: 10px;
  margin-bottom: 20px;
  border-radius: 4px;
  border: none;
}

</style>