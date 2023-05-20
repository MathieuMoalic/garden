<script>
    export let api;
    export let action;

    let turnPumpOn = async () => {
        await fetch(api + "/pump-" + action, { method: "get" }).then((res) =>
            res.json()
        );
    };
</script>

<div>
    <button on:click={turnPumpOn}> Pump {action} </button>
</div>

<style>
    div {
        display: flex;
    }
    button {
        color: aliceblue;
        background-color: black;
    }
</style>
