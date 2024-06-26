<script setup>
import { onMounted, ref, watch } from 'vue'
import { useRoute } from 'vue-router'
import { supabase } from '@/supabase'
import { get_user } from '@/authentication'
import { useToast } from 'vue-toastification'

const route = useRoute()
const id = ref(route.params.id)
const idea = ref(null)
const isSaved = ref(false)
const user = ref(null)

onMounted(async () => {
	user.value = await get_user()
	if (route.params.id) {
		updateDateIdea(route.params.id)
	}
})

watch(
	() => route.params.id,
	(newId) => {
		if (newId) {
			updateDateIdea(newId)
		}
	}
)

async function updateDateIdea(ideaId) {
	const { data, error } = await fetchDateIdea(ideaId)
	if (error) {
		console.error(error)
		return
	}
	idea.value = data[0]
	await checkProfileIdea(ideaId, user.value.id)
}

async function fetchDateIdea(ideaId) {
	return supabase.from('idea').select().eq('id', ideaId)
}

async function checkProfileIdea(ideaId, profileId) {
	const { data, error } = await supabase
		.from('profiles_ideas')
		.select()
		.eq('idea_id', ideaId)
		.eq('profile_id', profileId)

	if (error) {
		console.error(error)
		isSaved.value = false
		return
	}
	isSaved.value = data.length > 0 ? data[0].saved : false
}

async function toggleSaveIdea() {
	isSaved.value = !isSaved.value
	await updateProfileIdea(id.value, user.value.id, 'saved', isSaved.value)
}

async function updateProfileIdea(ideaId, profileId, field, value) {
	const { data, error: selectError } = await supabase
		.from('profiles_ideas')
		.select('*')
		.eq('idea_id', ideaId)
		.eq('profile_id', profileId)

	const toast = useToast()

	if (selectError) {
		console.error(selectError)
		toast.error('Error retrieving idea')
		return
	}

	if (data.length > 0) {
		const { error: updateError } = await supabase
			.from('profiles_ideas')
			.update({ [field]: value })
			.eq('idea_id', ideaId)
			.eq('profile_id', profileId)

		if (updateError) {
			toast.error('Fehler beim aktualisieren der Idee')
		} else {
			toast.success(value ? 'Idea saved!' : 'Idea unsaved!')
		}
	} else {
		const { error: insertError } = await supabase.from('profiles_ideas').insert({
			idea_id: ideaId,
			profile_id: profileId,
			[field]: value,
		})

		if (insertError) {
			toast.error('Fehler beim speichern der Änderungen')
		} else {
			toast.success(value ? 'Idea saved!' : 'Idea unsaved!')
		}
	}
}

function getImgUrl(date_id) {
	return new URL(`../assets/img/dates/${date_id}.webp`, import.meta.url).href
}
</script>

<template>
	<div>
		<article v-if="idea" class="idea">
			<div class="ideaLayout">
				<div class="date">
					<h2>{{ idea.title }}</h2>
					<p>{{ idea.description }}</p>
				</div>
				<div class="image">
					<img :src="getImgUrl(id)" alt="Date Idea Image" />
				</div>
			</div>
			<button class="shadow-button" @click="toggleSaveIdea">
				{{ isSaved ? 'Unsave' : 'Save' }}
			</button>
		</article>
		<p v-else>Loading...</p>
	</div>
</template>

<style scoped>
.idea {
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-direction: column;
	gap: 20px;
}

.ideaLayout {
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-direction: row;
	gap: 20px;
	margin: 1rem;
	padding: 1rem;
	background-color: #ffffff;
	border-radius: 4px;
}

.date {
	width: 70%;
}

.image {
	width: 30%;
}

.image img {
	width: 100%;
}
</style>
