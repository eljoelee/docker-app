<script>
    let name = "eljoe";
    let str = "안녕하세요! <strong>이지오</strong>입니다.";
    
    let num = 0;

    const increaseNumber = () => num++;
    const decreaseNumber = () => num--;

    let count = 1;
    $: doubled = count * 2;
    $: square = count * count;

    const increaseCount = () => count++;
    
    $: users = fetch('https://randomuser.me/api/?results=5')
    .then(response => response.json())
    .then(data => data.results)
</script>

<h1>Number</h1>
<button on:click={increaseNumber}>증가</button>
<button on:click={decreaseNumber}>감소</button>

<hr/>

<h1>Count</h1>
<button on:click={increaseCount}>{ count }</button>

<h3>두배 : { count } * 2 = { doubled }</h3>
<h3>제곱 : { count } * { count } = { square }</h3>
<hr/>

<h1>{ num }</h1>
<h1>Hello {name}</h1>
<p>{ @html str }</p>


{#await users}
    <p>...Loading</p>
    {:then users}
        {#each users as user}
            <img src={user.picture.large} alt="">
            <p>{user.name.first} {user.name.last}</p>
        {/each}
    {:catch error}
        <p>Error!</p>
{/await}
