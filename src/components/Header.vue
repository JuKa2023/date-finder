<template>
  <header>
    <div class="containerheader">
      <nav>
        <ul>
          <li class="dropdown">
            <a href="/"><img class="iconheader" src="/img/logo_datefinderr.svg" alt="Home"></a>
            <div class="dropdown-content">
              <a href="/">Date Suchen</a>
              <!-- Add additional links here if needed -->
            </div>
          </li>
          <li class="dropdown">
            <a href="/"><img class="iconheader" src="/img/icon_Konto.svg" alt="Konto"></a>
            <div class="dropdown-content">
              <a href="/">Konto Einstellungen</a>
              <a href="/">Logout</a>
              <!-- Add additional links here if needed -->
            </div>
          </li>
        </ul>
      </nav>
    </div>
  </header>
</template>

<script>
export default {
  name: 'Header',
}
</script>

<style>
/* Header component styling */
header {
  background-color: #fefafd;
  padding: 10px;
  font-family: 'Poppins', sans-serif;
}

nav ul {
  display: flex;
  justify-content: space-between;
  align-items: center;
  list-style-type: none;
  padding: 0 20px;
}

nav ul li {
  position: relative;
  margin-right: 10px;
  font-size: 18px;
}

nav ul li a {
  text-decoration: none;
  color: #000;
  display: flex;
  align-items: center;
}

nav ul li a:hover {
  color: #D77F8F;
}

.iconheader {
  height: 30px;
}

/* Dropdown Menu Styles */
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
  width: 200px;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {
  background-color: #f1f1f1;
}

.dropdown:hover .dropdown-content {
  display: block;
}
</style>
