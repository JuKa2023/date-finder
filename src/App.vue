<script setup>
import { ref, computed } from 'vue'
import { supabase } from '@/supabase'
import { useRouter } from 'vue-router'

const router = useRouter()
const is_logged_in = ref(false)
const isLoggedIn = computed(() => is_logged_in.value)

supabase.auth.onAuthStateChange(async (event) => {
	if (event === 'SIGNED_OUT') {
		is_logged_in.value = false
	} else if (event === 'SIGNED_IN') {
		is_logged_in.value = true
	}
})

async function handle_logout() {
	const { error } = await supabase.auth.signOut()
	console.log(error)
	if (!error) {
		is_logged_in.value = false
		await router.push('/login')
	}
}
</script>

<template>
	<header>
		<div class="containerheader">
			<nav>
				<ul>
					<li>
						<a href="/date-finder/">
							<img alt="Home" class="iconHeader home-icon" src="/src/assets/img/logo.svg" />
						</a>
					</li>
					<div v-if="isLoggedIn" class="icons-container">
						<li>
							<a href="/date-finder/find/">
								<img
									alt="Search"
									class="iconHeader search-icon"
									src="/src/assets/img/icons/search.svg"
								/>
							</a>
						</li>
						<li class="dropdown">
							<a href="/date-finder/" aria-haspopup="true" aria-expanded="false">
								<img
									alt="Konto"
									class="iconHeader account-icon"
									src="/src/assets/img/icons/konto.svg"
								/>
							</a>
							<div class="dropdown-content" aria-labelledby="accountMenu">
								<RouterLink to="/account">Mein Konto</RouterLink>
								<a @click.prevent="handle_logout">Logout</a>
							</div>
						</li>
					</div>
					<li v-else class="loginreg">
						<RouterLink to="/login" class="linkOnly">Login</RouterLink>
						<RouterLink to="/register" class="linkOnly">Registrieren</RouterLink>
					</li>
				</ul>
			</nav>
		</div>
	</header>

	<main>
		<router-view></router-view>
	</main>
</template>

<style scoped>
header {
	padding-top: 10px;
	padding-left: 10px;
	padding-right: 10px;
	font-family: 'Poppins', sans-serif;
	background-color: #d79595;
	position: sticky; /* Make header sticky */
	top: 0; /* Position it at the top of the viewport */
	z-index: 1000; /* Ensure it stays on top of other content */
}

nav ul {
	display: flex;
	justify-content: space-between;
	align-items: center;
	list-style-type: none;
	padding: 0 10px;
	margin-top: 10px;
	margin-bottom: 0px;
}

nav ul li {
	position: relative;
	margin-right: 10px;
	font-size: 18px;
}

nav ul li a {
	text-decoration: none;
	color: #d0a8c5;
	display: flex;
	align-items: center;
}

nav ul li a:focus,
nav ul li a:hover {
	color: #ebcfcd;
	outline: none;
}

.iconHeader {
	padding-bottom: 10px;
	transition: transform 0.6s ease;
	transform-origin: center;
}

.home-icon {
	height: 40px;
}

.search-icon,
.account-icon {
	height: 25px;
	transition: none;
}

.icons-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: 15%;
}

.containerheader {
	max-width: 1000px;
	margin: 0 auto;
	width: 100%;
}

.loginreg {
	display: flex;
	justify-content: space-between;
	gap: 40px;
}

.dropdown-content {
	display: block;
	position: absolute;
	background-color: #29223c;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
	width: 200px;
	opacity: 0;
	visibility: hidden;
	transform: translateY(-20px);
	transition:
		opacity 0.5s ease,
		transform 0.5s ease,
		visibility 0.5s;
}

.dropdown:hover .dropdown-content {
	opacity: 1;
	visibility: visible;
	transform: translateY(0px);
}

.dropdown-content a {
	color: #d0a8c5;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
	cursor: pointer;
}

.dropdown-content a:focus,
.dropdown-content a:hover {
	color: #ebcfcd;
	background-color: #2a2130;
}

nav ul li:last-child .dropdown-content {
	right: 0;
}

.faint-line {
	border: none;
	height: 1px;
	background-color: #211230;
	margin-top: 20px;
	margin-bottom: 20px;
}

.linkOnly {
	color: black;
	text-decoration: none;
}

.linkOnly:hover {
	color: #ebcfcd;
}
</style>
