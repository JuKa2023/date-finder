<script setup>
import { ref, onMounted } from 'vue'
import MultiStep from '@/components/MultiStep.vue'
import DateList from '@/components/DateList.vue'
import SearchStepOne from './steps/SearchStepOne.vue'
import SearchStepTwo from './steps/SearchStepTwo.vue'
import SearchStepThree from './steps/SearchStepThree.vue'
import SearchStepFour from './steps/SearchStepFour.vue'
import SearchStepFive from './steps/SearchStepFive.vue'
import { supabase } from '@/supabase'
import { useToast } from 'vue-toastification'

const SEARCH_CACHE_KEY = 'tagsJson'

const registerSteps = [
	{ name: 'StepOne', path: '@/components/search', component: SearchStepOne },
	{ name: 'StepTwo', path: '@/components/search', component: SearchStepTwo },
	{ name: 'StepThree', path: '@/components/search', component: SearchStepThree },
	{ name: 'StepFour', path: '@/components/search', component: SearchStepFour },
	{ name: 'StepFive', path: '@/components/search', component: SearchStepFive },
]

const isLoading = ref(false)
const isComplete = ref(false)
const searchTags = ref([])
const results = ref([])
const restrictions = ref([])
const toast = useToast()

const getCachedSearch = () => {
	const tagsJson = localStorage.getItem(SEARCH_CACHE_KEY)
	if (tagsJson) {
		searchTags.value = JSON.parse(tagsJson)
		isComplete.value = true
		updateSearchResults()
	}
}

const saveSearch = (tagsJson) => {
	localStorage.setItem(SEARCH_CACHE_KEY, JSON.stringify(tagsJson))
}

const clearSearch = () => {
	localStorage.removeItem(SEARCH_CACHE_KEY)
	isComplete.value = false
	searchTags.value = []
	results.value = []
}

const getIdeasByTags = async (selectedOptions) => {
	try {
		const { data, error } = await supabase.rpc('get_ideas_by_tags_json', {
			input_json: { tags: selectedOptions },
		})
		if (error) throw error
		return data.map((idea) => ({
			...idea,
			id: idea.idea_id,
		}))
	} catch (error) {
		console.error('Error fetching ideas by tags:', error)
		return []
	}
}

const getAllTags = async () => {
	try {
		const { data, error } = await supabase.from('tag').select()
		if (error) throw error
		restrictions.value = data
	} catch (error) {
		console.error('Error fetching all tags:', error)
	}
}

const handleFilterComplete = (results) => {
	isComplete.value = true
	searchTags.value = Array.from(results.results)
	saveSearch(searchTags.value)
	updateSearchResults()
}

const updateSearchResults = async () => {
  if (!searchTags.value.length) return

  isLoading.value = true
  let ideas = await getIdeasByTags(searchTags.value)

  const searchTagsSet = new Set(searchTags.value);
  ideas = ideas.sort((a, b) => {
    const aCommon = a.tags.filter(tagName => searchTagsSet.has(tagName)).length;
    const bCommon = b.tags.filter(tagName => searchTagsSet.has(tagName)).length;

    if (aCommon === bCommon) {
      return a.title.localeCompare(b.name);
    }

    return bCommon - aCommon;
  })

  results.value = ideas
  isLoading.value = false
}


const removeRestriction = (tagName) => {
	searchTags.value = searchTags.value.filter((tag) => tag !== tagName)
	if (!searchTags.value.length) {
		clearSearch()
		toast.info('Nothing to search for.')
	} else {
		saveSearch(searchTags.value)
		updateSearchResults()
	}
}

onMounted(() => {
	getCachedSearch()
	getAllTags()
})
</script>

<template>
	<button v-if="isComplete" class="shadow-button" @click="clearSearch">Clear Search</button>

	<MultiStep v-if="!isComplete" :steps="registerSteps" @all-steps-complete="handleFilterComplete" />

	<main v-else class="format">
		<h1>Das sind die Top auswahlen für dein Date</h1>
		<p>
			Die Resultate werden basierend auf deinem Input und deinen Interessen sortiert, wobei das am
			besten passende zuerst angezeigt wird. Es werden nur Ergebnisse angezeigt, die du noch nicht
			durchgeführt hast.
		</p>

		<section class="chips">
			<div v-for="tag in searchTags" :key="tag" class="chip" @click="removeRestriction(tag)">
				<span>{{ tag }}</span>
			</div>
		</section>

		<DateList :date_objects="results" :isLoading="isLoading"></DateList>
	</main>
</template>

<style scoped>
.format {
	max-width: 800px;
	margin: 0 auto;
	padding: 20px;
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
	border: #7a798c 1px solid;
	border-radius: 25px;
	background-color: #ffffff;
	margin: 2px;
	color: #7a798c;
}
</style>
