<script setup>
import { onMounted, ref } from 'vue';
import movies from './movies.json'

import Magnify from 'vue-material-design-icons/Magnify.vue';
import HomeOutline from 'vue-material-design-icons/HomeOutline.vue';
import TrendingUp from 'vue-material-design-icons/TrendingUp.vue';
import Television from 'vue-material-design-icons/Television.vue';
import MovieOutline from 'vue-material-design-icons/MovieOutline.vue';
import Plus from 'vue-material-design-icons/Plus.vue';
import ChevronLeft from 'vue-material-design-icons/ChevronLeft.vue';

import VideoCarousel from '@/components/VideoCarousel.vue';
import MovieDetails from '@/components/MovieDetails.vue';

import { useMovieStore } from './stores/movie'
import { storeToRefs } from 'pinia';
const useMovie = useMovieStore()
const { movie, showFullVideo, carouselX, carouselY } = storeToRefs(useMovie)

let video = ref(null)

window.addEventListener('keydown', (ev) => {
  console.log('keydown');
  console.log(carouselX.value, carouselY.value);
  const e = ev || window.event;
  if (e.key == 'ArrowLeft' || e.key == '4') {
    if (showFullVideo.value === true) {
      showFullVideo.value = false
    } else if (carouselX.value > 0) {
      carouselX.value = carouselX.value - 1;
      movie.value = movies[carouselY.value][carouselX.value];
    }
  } else if (e.key == 'ArrowRight' || e.key == '6') {
    if (showFullVideo.value === true) {
      showFullVideo.value = false
    } else if (carouselX.value < movies[carouselY.value].length - 1) {
      carouselX.value = carouselX.value + 1;
      movie.value = movies[carouselY.value][carouselX.value];
    }
  } else if (e.key == 'ArrowUp' || e.key == '2') {
    if (showFullVideo.value === true) {
      showFullVideo.value = false
    } else if (carouselY.value > 0) {
      carouselY.value = carouselY.value - 1;
      carouselX.value = 0
      movie.value = movies[carouselY.value][carouselX.value];
      document.getElementById('car-'+carouselY.value).scrollIntoView();
    }
  } else if (e.key == 'ArrowDown' || e.key == '8') {
    if (showFullVideo.value === true) {
      showFullVideo.value = false
    } else if (carouselY.value < 2) {
      carouselY.value = carouselY.value + 1;
      carouselX.value = 0;
      movie.value = movies[carouselY.value][carouselX.value];
      document.getElementById('car-'+carouselY.value).scrollIntoView();
    }
  } else if (e.key == '5') {
    if (showFullVideo.value === false) {
      setTimeout(() => showFullVideo.value = true, 500)
    }
  }

  // document.getElementById("BtnControle").innerHTML = `${e.keyCode} ${e.key}`;
});


onMounted(() => {
  setTimeout(() => movie.value = movies[0][0], 100)
})
</script>

<template>
  <div class="fixed w-full h-screen bg-black cursor-none">

    <!---<div id="BtnControle" class="bg-white relative z-100" style="z-index:100"></div>-->
    <div v-if="!showFullVideo" id="SideNav" class="flex z-40 items-center w-[120px] h-screen bg-black relative">
      <img class="absolute top-0 w-[35px] mt-10 ml-10" src="/images/netflix-logo.png" alt="">
      <div>
        <div class="py-2 mx-10 my-6">
          <Magnify fillColor="#FFFFFF" :size="40"/>
        </div>
        <div class="py-2 mx-10 my-6 border-b-4 border-b-red-500">
          <HomeOutline fillColor="#FFFFFF" :size="40"/>
        </div>
        <div class="py-2 mx-10 my-6">
          <TrendingUp fillColor="#FFFFFF" :size="40"/>
        </div>
        <div class="py-2 mx-10 my-6">
          <Television fillColor="#FFFFFF" :size="40"/>
        </div>
        <div class="py-2 mx-10 my-6">
          <MovieOutline fillColor="#FFFFFF" :size="40"/>
        </div>
        <div class="py-2 mx-10 my-6">
          <Plus fillColor="#FFFFFF" :size="40"/>
        </div>
      </div>
    </div>

    <div v-if="!showFullVideo">
      <div class="fixed flex z-20 top-0 right-0 w-full h-[50%] bg-black pl-[120px] bg-clip-border">
        <div class="absolute z-30 h-[600px] left-[120px] w-[77%] right-0 top-0 bg-gradient-to-r from-black via-black" />
        
        <MovieDetails v-if="movie" :movie="movie" />

        <video 
          v-if="movie" 
          :src="'/videos/'+movie.name+'.mp4'" 
          autoplay 
          loop
          class="absolute z-0 h-[600px] right-0 top-0"
        />

      </div>

      <div class="fixed z-30 bottom-0 right-0 w-full h-[55%] pl-[120px] overflow-y-hidden">
        <div class="fixed z-30 bottom-0 right-0 w-full h-[55%] pl-[120px] overflow-y-hidden">
          <VideoCarousel id="car-0" class="pb-14 pt-14" category="Popular Movies" :movies="movies[0]" v-bind:y="0"/>
          <VideoCarousel id="car-1" class="pb-14" category="Horror Movies" :movies="movies[1]" v-bind:y="1"/>
          <VideoCarousel id="car-2" class="pb-32" category="Featured Movies" :movies="movies[2]" v-bind:y="2"/>
        </div>
      </div>

      <div class="absolute z-20 h-[70%] left-[120px] w-[100%] right-0 bottom-0 bg-gradient-to-t from-black via-black" />
    </div>

    <div v-if="showFullVideo">
      <div @click="showFullVideo = false" class="absolute z-50 p-2 m-4 bg-white bg-opacity-50 rounded-full">
        <ChevronLeft fillColor="#FFFFFF" :size="40"/>
      </div>
      <video 
        :src="'/videos/'+movie.name+'.mp4'" 
        autoplay 
        loop
        controls
        class="absolute z-0 w-[100vw] h-full object-fit"
      />
    </div>

  </div>

</template>
