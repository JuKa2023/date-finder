<script setup>
import { supabase } from '@/supabase'
import { onMounted, ref, watchEffect } from 'vue'
import { get_user } from '@/authentication'
import { useToast } from 'vue-toastification'

const loading = ref(true)

const email = ref('')
const username = ref('')
const firstName = ref('')
const avatar_url = ref('')
const password = ref('')
const restrictions = ref('')

const isModified = ref(false)

onMounted(async () => {
	await getProfile()
})

async function getProfile() {
	try {
		const user = await get_user()
		const { data, error, status } = await supabase
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
	} catch (error) {
		const toast = useToast()
		toast.error(error.message, {
			timeout: 5000,
		})
	} finally {
		loading.value = false
	}
}

async function updateProfile() {
	try {
		loading.value = true
		const user = await get_user()

		const updates = {
			id: user.id,
			username: username.value,
			full_name: firstName.value,
			avatar_url: avatar_url.value,
			updated_at: new Date(),
		}

		const { error } = await supabase.from('profiles').upsert(updates)

		const toast = useToast()

		if (!error) toast.success('Profil erfolgreich aktualisiert')
		else toast.error('Fehler beim Aktualisieren des Profils')

		if (error) throw error
	} catch (error) {
		alert(error.message)
	} finally {
		loading.value = false
	}
}

watchEffect(() => {
	isModified.value =
		email.value !== '' ||
		username.value !== '' ||
		firstName.value !== '' ||
		password.value !== '' ||
		restrictions.value !== ''
})

function handleChange() {
	isModified.value = true
}
</script>

<template>
	<article class="account-settings">
		<h1>Konto-Einstellungen</h1>
		<form class="settings-form" @submit.prevent="updateProfile">
			<div class="input-group">
				<label for="email">E-Mail:</label>
				<input id="email" v-model="email" disabled type="email" />
			</div>
			<div class="input-group">
				<label for="username">Benutzername:</label>
				<input id="username" v-model="username" type="text" @input="handleChange" />
			</div>
			<div class="input-group">
				<label for="firstName">Vorname:</label>
				<input id="firstName" v-model="firstName" type="text" @input="handleChange" />
			</div>
			<div class="input-group">
				<label for="password">Passwort:</label>
				<input id="password" v-model="password" type="password" @input="handleChange" />
			</div>
			<div class="input-group">
				<label for="restrictions">Einschränkungen:</label>
				<input id="restrictions" v-model="restrictions" type="text" @input="handleChange" />
			</div>
			<button v-if="isModified" :disabled="loading" class="update-button">
				{{ loading ? 'Aktualisieren...' : 'Profil aktualisieren' }}
			</button>
		</form>
	</article>
</template>

<style scoped>
.account-settings {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	width: 80%;
	max-width: 600px;
	margin: 50px auto;
	padding: 30px;
	background: linear-gradient(145deg, #ffffff, #f6f6f6);
	border-radius: 12px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
}

.settings-form {
	width: 100%;
	display: flex;
	flex-direction: column;
}

.input-group {
	display: flex;
	flex-direction: column;
	margin-bottom: 20px;
}

label {
	font-family: 'Roboto', sans-serif;
	color: #333;
	font-size: 16px;
	margin-bottom: 5px;
	font-weight: 500;
}

.input {
	padding: 12px;
	border: 2px solid #dcdcdc;
	border-radius: 6px;
	background: white;
	color: #333;
	font-size: 16px;
	transition: all 0.3s ease-in-out;
}

.input:focus {
	border-color: #405983;
	box-shadow: 0 2px 8px rgba(0, 123, 255, 0.2);
}

.update-button {
	padding: 12px 20px;
	margin-top: 10px;
	background-color: #405983;
	color: white;
	border: none;
	border-radius: 6px;
	font-size: 16px;
	cursor: pointer;
	transition: all 0.3s ease-in-out;
	background-image: linear-gradient(45deg, #405983, #587abc);
}

.update-button:hover {
	background-image: linear-gradient(45deg, #364b73, #4e6ca3);
	transform: translateY(-3px);
	box-shadow: 0 4px 10px rgba(54, 75, 115, 0.25);
}

.update-button:disabled {
	background-color: #ccc;
	cursor: not-allowed;
	opacity: 0.7;
}

.error-message {
	color: #ff3860;
	margin-top: 12px;
	text-align: center;
	font-size: 14px;
	font-weight: 500;
}
</style>
