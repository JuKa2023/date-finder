<script setup>

console.log('Hello World, this is the Landing Page');

</script>

<template>
    <section class="format">
        <h1>
            Date Finder
        </h1>
        <div class="content-container">
            <div class="text-container">

                <p>
                    Melde dich bei uns an und lass dich von kreativen, saisonabhängigen Date-Vorschlägen inspirieren, die genau zu dir passen. Der "Date Generator" kickt die Alltagsroutine aus eurem Leben und bringt frischen Wind in eure Dates! Leg einfach los, erstelle dein Profil und tauche ein in eine Welt voller einzigartiger Aktivitäten, perfekt für jede Jahreszeit. Unsere Plattform ist super easy zu bedienen und basiert auf den neuesten Technologien, damit euer Erlebnis smooth und spannend bleibt. Mach jeden gemeinsamen Moment zu einem Highlight mit dem Date Generator, weil eure Zeit zu zweit einfach unbezahlbar ist!
                </p>
                <h2>
                    Han ich dis Interesse gweckt?
                </h2>
                
            </div>

            <div class="image-content">
                <img src="/img/platzhalter.png" alt="">
            </div>
        </div>
        <h3>
            Den los meld dich a.
        </h3>
        <button class="shadow-button">Click Me</button>
    </section>
</template>

<style>

    .format {
        max-width: 1000px;
        display: flex;  
        justify-content: space-between;
        align-items: center;
        flex-direction: column;
        width: 100%;
        margin: 0 auto;
    }

    .content-container {
        display: flex;
        justify-content: space-between; 
        width: 100%;
        margin: 0 auto;
        gap: 20px;
    }

    .text-container {
        flex: 0 0 60%;
        padding-right: 80px;
    }

    .image-container {
        flex: 0 0 30%;
        display: flex;
        justify-content: center;
        align-items: center;
        padding-left: 40px;
    }

    img {
        max-width: 100%;
        height: auto;
    }

</style>