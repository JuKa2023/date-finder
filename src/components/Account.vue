<script setup>
import { ref, onMounted, watchEffect } from 'vue'
import { supabase } from '@/supabase'
import { get_user } from '@/authentication'
import { useToast } from 'vue-toastification'

const toast = useToast()
const loading = ref(true)
const email = ref('')
const username = ref('')
const firstName = ref('')
const password = ref('')
const confirmPassword = ref('')
const isModified = ref(false)

const initialEmail = ref('')
const initialUsername = ref('')
const initialFirstName = ref('')

// Fetch the initial profile data
onMounted(async () => {
	await fetchProfile()
})

// Watch for changes to form fields to enable the update button
watchEffect(() => {
	isModified.value =
		email.value !== initialEmail.value ||
		username.value !== initialUsername.value ||
		firstName.value !== initialFirstName.value ||
		password.value !== '' ||
		confirmPassword.value !== ''
})

async function fetchProfile() {
	try {
		const user = await get_user()
		const { data, error, status } = await supabase
			.from('profiles')
			.select()
			.eq('id', user.id)
			.single()

		if (error && status !== 406) throw error
		if (data) {
			email.value = initialEmail.value = user.email
			firstName.value = initialFirstName.value = data.full_name
			username.value = initialUsername.value = data.username
		}
	} catch (error) {
		toast.error(error.message, { timeout: 5000 })
	} finally {
		loading.value = false
	}
}

async function updateProfile() {
	if (!isModified.value) return

	loading.value = true
	try {
		if (password.value || confirmPassword.value) {
			await updatePassword()
			return
		}

		const user = await get_user()
		const updates = {
			id: user.id,
			username: username.value,
			full_name: firstName.value,
			updated_at: new Date(),
		}

		const { error } = await supabase.from('profiles').upsert(updates)
		if (error) throw error

		toast.success('Profil erfolgreich aktualisiert')
		updateInitialValues()
	} catch (error) {
		toast.error(error.message)
	} finally {
		loading.value = false
	}
}

function updateInitialValues() {
	initialEmail.value = email.value
	initialUsername.value = username.value
	initialFirstName.value = firstName.value
	isModified.value = false
}

async function updatePassword() {
	if (password.value !== confirmPassword.value) {
		toast.error('Passwörter stimmen nicht überein')
		return
	}

	const { data, error } = await supabase.auth.updateUser({
		password: password.value,
	})

	if (error) {
		toast.error(error.message, { timeout: 7000 })
		password.value = ''
		confirmPassword.value = ''
		return
	}

	toast.success('Passwort erfolgreich aktualisiert')
}

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
				<label for="confirmPassword">Passwort bestätigen:</label>
				<input
					id="confirmPassword"
					v-model="confirmPassword"
					type="password"
					@input="handleChange"
				/>
				<p v-if="passwordError" class="error-message">{{ passwordError }}</p>
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
	color: #333;
	font-size: 16px;
	margin-bottom: 5px;
	font-weight: 500;
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

.input-group input {
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	font-size: 16px;
}
</style>
