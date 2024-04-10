<template>
    <article>
        <section class="cardNotClick">
            <div>
                <h2 class="activity"> aktive </h2>
            </div>
            <img class="Bildcard" src="/img/Platzhalter.png" alt="illustration der Aktivität">
            <img class="logo" src="/img/Platzhalter.png" alt="illustration der Aktivität">
        </section>
    </article>
</template>

<Style>
    .cardNotClick{
        background-color: #fefafd;
        padding: 10px 20px;
        margin: auto;
        font-family: 'poppins bold', sans-serif;
        max-width: 20%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        border-radius: 10px;
        box-shadow: 0 4px 8px 0px rgba(33, 18, 48, 1);
    }

.chips{
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    margin-top: 10px;
}
    .chip{
        display: inline-block;
        padding: 0 25px;
        height: 40px;
        font-size: 16px;
        line-height: 40px;
        border: #7A798C 1px solid;
        border-radius: 25px;
        background-color: #ffffff;
        margin: 5px;
        cursor: default;
        color: #7A798C;
    }
    .activity{
        margin-bottom: 0px;
    }
    .Bildcard{
        margin: 10px;
        max-width: 80%;
    }

    .logo{
        margin: 10px;
        max-width: 10%;
    }
</Style>
