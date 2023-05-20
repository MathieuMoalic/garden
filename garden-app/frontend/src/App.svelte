<script>
  import { onMount } from "svelte";
  import PumpToggleButton from "./PumpToggleButton.svelte";

  let api = "./api";
  let pumpIsOn;

  onMount(async () => {
    pumpIsOn = await fetch("./api/pump-status").then((res) => res.json());
  });
</script>

<main>
  <PumpToggleButton {api} action="on" />
  <PumpToggleButton {api} action="off" />
  <!-- <PumpStatus {api} /> -->
  {#await pumpIsOn}
    <p>...waiting</p>
  {:then number}
    <p>The number is {number}</p>
  {:catch error}
    <p style="color: red">{error.message}</p>
  {/await}
  {#if pumpIsOn == ""}
    Fetching
  {:else if pumpIsOn}
    Pump is running
  {:else if !pumpIsOn}
    Pump is not running
  {:else}
    Error getting the status of the pump
  {/if}
</main>

<style>
  :global(body) {
    margin: 0px;
    border: 0px;
    padding: 0px;
    color: aliceblue;
    font-size: large;
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    font-weight: 400;
    padding-bottom: 90%;
    background-image: url("/background.avif");
    background-attachment: fixed;
  }
</style>
