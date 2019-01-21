<template>
	<button 
        class="box" 
        @click="$emit('fill')" 
        :class="{ 'isX': value == 1, 'isO': value == 2, 'isWin': win }"
    >
    </button>
</template>

<script>
export default {
    name: 'Box',
    props: ['value','win']
}
</script>