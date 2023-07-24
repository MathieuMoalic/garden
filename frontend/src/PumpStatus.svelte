<script>
    import { onMount } from "svelte";

    let pumpStatus;
    let currentTime = new Date();

    let getPumpStatus = async () => {
        let res = await fetch("./api/pump-status").then((res) => res.json());
        pumpStatus = res.status;
        currentTime = new Date();
    };
    let turnPumpOn = async () => {
        await fetch("./api/pump-on");
        getPumpStatus();
    };
    let turnPumpOff = async () => {
        await fetch("./api/pump-off");
        getPumpStatus();
    };

    onMount(async () => {
        await getPumpStatus();
        setInterval(getPumpStatus, 300000);
    });
</script>

<div class="outer">
    {#await pumpStatus}
        <p>...getting the pump status</p>
    {:then}
        <div class="pump-label">Pump is {pumpStatus}</div>
        <div class="time">
            Last update: {currentTime.toLocaleString("en-US")}
        </div>
    {:catch error}
        <p style="color: red">{error.message}</p>
    {/await}
    <button on:click={getPumpStatus}>Refresh status</button>
    <button on:click={turnPumpOn}>Pump on</button>
    <button on:click={turnPumpOff}>Pump off</button>
</div>

<style>
    .time {
        font-size: small;
    }
</style>
