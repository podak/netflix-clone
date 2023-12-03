import { defineStore } from 'pinia'

export const useMovieStore = defineStore('movie', {
  state: () => ({
    movie: null,
    showFullVideo: false,
    carouselY:0,
    carouselX:0
  }),
})
