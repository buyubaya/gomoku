<template>
	<div id="app">
		<Board />
	</div>
</template>

<script>
import Board from "./components/Board.vue";

export default {
	name: "app",
	components: {
		Board
	}
};
</script>

<style>
*,:before,:after { box-sizing: border-box; }

#app {
	overflow-x: hidden;
}

body {
	font-family: "Avenir", Helvetica, Arial, sans-serif;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	text-align: center;
	color: #2c3e50;
	margin-top: 20px;
	background: #ccffdd;
}

.board {
  	margin: 0 auto;
	background: #fff;
}

.board .box {
    float: left;
    box-sizing: border-box;
    width: 50px;
    height: 50px;
    line-height: 1;
    background: transparent;
    border: 1px solid #ccc;
}

.board:after {
	content: '';
	display: block;
	clear: both;
}

.box.isX {
    position: relative;
}
.box.isX:before, .box.isX:after {
    content: "";
    display: block;
    width: 100%;
    height: 5px;
    background: #ff6699;
    position: absolute;
    top: 50%;
    left: 0%;
    transform: rotate(45deg);
}
.box.isX:after {
    transform: rotate(-45deg);
}

.box.isO {
    position: relative;
}
.box.isO:before {
    content: "";
    display: block;
    width: 100%;
    height: 100%;
    border-radius: 50%;
    border: 5px solid #00cc99;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-50%);     
}

.box.isWin {
    background: #ccc;
}

.playerNotification {
	padding: 10px;
	font-size: 1.5em;
	font-weight: bold;
	width: 200px;
	position: absolute;
	top: 25%;
	transform: rotateX(90deg);
	transition: transform 0.5s;
}

.playerNotification.isActive {
	transform: rotateX(0deg);
}

.playerNotification.player-1 {
	background: #ff6699;
	left: 0;
}

.playerNotification.player-2 {
	background: #00cc99;
	right: 0;
}

.messageNotification {
	position: absolute;
	top: 35%;
	left: 50%;
	transform: translateX(-50%);
	background: #66ff66;
	border: 2px solid #009900;
	border-radius: 5px;
	font-size: 1.5em;
	font-weight: bold;
	width: 300px;
	text-align: center;
	padding: 20px;
}

.controlArea button {
	padding: 20px;
	width: 100px;
	text-align: center;
	background: #fff;
	box-shadow: none;
	border: 2px solid #ccc;
	cursor: pointer;
	margin: 10px;
}

.controlArea button.isDisabled {
	background: #e1e1e1;
	pointer-events: none;
}
</style>
