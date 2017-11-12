<template>
  <div>
     <canvas ref="canvas" style="display:block;position:relative;z-index:999;background:transparent">
        当前浏览器不支持Canvas，请更换浏览器后再试
    </canvas>
  </div>
</template>

<script>
   import digit from './digit.js';
   export default {
     data(){
      return {
          curShowTimeSeconds:0,
          balls:[],
          colors:["#33B5E5","#0099CC","#AA66CC","#9933CC","#99CC00","#669900","#FFBB33","#FF8800","#FF4444","#CC0000"],

        }
     },
     props:["cWidth",   //画布宽
            "cHeight",
            "radius",
            "marTop",
            "marLeft"],
     methods:{
       /**
        * [getSeconds 获取当前时间]
        * @Author   罗文
        * @DateTime 2017-11-12
        * @return   {[Number]}   [返回当天这个时间的秒数]
        */
       getSeconds() {
          let date = new Date();
          let hours = date.getHours();
          let minutes = date.getMinutes();
          let seconds = date.getSeconds();

          return hours * 3600 + minutes * 60 + seconds;
       },


      update(){
          let nextShowTimeSeconds = this.getSeconds();

          let nextHours = parseInt( nextShowTimeSeconds / 3600);
          let nextMinutes = parseInt( (nextShowTimeSeconds - nextHours * 3600)/60 )
          let nextSeconds = nextShowTimeSeconds % 60

          let curHours = parseInt( this.curShowTimeSeconds / 3600);
          let curMinutes = parseInt( (this.curShowTimeSeconds - curHours * 3600)/60 )
          let curSeconds = this.curShowTimeSeconds % 60

          if( nextSeconds != curSeconds ){
              if( parseInt(curHours/10) != parseInt(nextHours/10) ){
                  this.addBalls( this.marLeft + 0 , this.marTop , parseInt(curHours/10) );
              }
              if( parseInt(curHours%10) != parseInt(nextHours%10) ){
                  this.addBalls( this.marLeft + 15*(this.radius+1) , this.marTop , parseInt(curHours/10) );
              }

              if( parseInt(curMinutes/10) != parseInt(nextMinutes/10) ){
                  this.addBalls( this.marLeft + 39*(this.radius+1) , this.marTop , parseInt(curMinutes/10) );
              }
              if( parseInt(curMinutes%10) != parseInt(nextMinutes%10) ){
                  this.addBalls( this.marLeft + 54*(this.radius+1) , this.marTop , parseInt(curMinutes%10) );
              }

              if( parseInt(curSeconds/10) != parseInt(nextSeconds/10) ){
                  this.addBalls( this.marLeft + 78*(this.radius+1) , this.marTop , parseInt(curSeconds/10) );
              }
              if( parseInt(curSeconds%10) != parseInt(nextSeconds%10) ){
                  this.addBalls( this.marLeft + 93*(this.radius+1) , this.marTop , parseInt(nextSeconds%10) );
              }

              this.curShowTimeSeconds = nextShowTimeSeconds;
          }

          this.updateBalls();

      },


      updateBalls(){
          for( let i = 0 ; i < this.balls.length ; i ++ ){

              this.balls[i].x += this.balls[i].vx;
              this.balls[i].y += this.balls[i].vy;
              this.balls[i].vy += this.balls[i].g;

              if( this.balls[i].y >= this.cHeight-this.radius ){
                  this.balls[i].y = this.cHeight-this.radius;
                  this.balls[i].vy = - this.balls[i].vy*0.65;
              }
          }

          let cnt = 0
          for( let i = 0 ; i < this.balls.length ; i ++ )
              if( this.balls[i].x + this.radius > 0 && this.balls[i].x -this.radius < this.cWidth )
                  this.balls[cnt++] = this.balls[i]

          while( this.balls.length > cnt ){
              this.balls.pop();
          }
      },


      addBalls( x , y , num ){
        for( let i = 0  ; i < digit[num].length ; i ++ )
            for( let j = 0  ; j < digit[num][i].length ; j ++ )
                if( digit[num][i][j] == 1 ){
                    let aBall = {
                        x:x+j*2*(this.radius+1)+(this.radius+1),
                        y:y+i*2*(this.radius+1)+(this.radius+1),
                        g:2+Math.random(),
                        vx:Math.pow( -1 , Math.ceil( Math.random()*1000 ) ) * 4,
                        vy:-5,
                        color: this.colors[ Math.floor( Math.random()*this.colors.length ) ]
                    }

                    this.balls.push( aBall )
                }
         },


      render( cxt ){
        cxt.clearRect(0,0,this.cWidth, this.cHeight);

        let hours = parseInt( this.curShowTimeSeconds / 3600);
        let minutes = parseInt( (this.curShowTimeSeconds - hours * 3600)/60 )
        let seconds = this.curShowTimeSeconds % 60

        this.renderDigit( this.marLeft , this.marTop , parseInt(hours/10) , cxt )
        this.renderDigit( this.marLeft + 15*(this.radius+1) , this.marTop , parseInt(hours%10) , cxt )
        this.renderDigit( this.marLeft + 30*(this.radius+1) , this.marTop , 10 , cxt )
        this.renderDigit( this.marLeft + 39*(this.radius+1) , this.marTop , parseInt(minutes/10) , cxt);
        this.renderDigit( this.marLeft + 54*(this.radius+1) , this.marTop , parseInt(minutes%10) , cxt);
        this.renderDigit( this.marLeft + 69*(this.radius+1) , this.marTop , 10 , cxt);
        this.renderDigit( this.marLeft + 78*(this.radius+1) , this.marTop , parseInt(seconds/10) , cxt);
        this.renderDigit( this.marLeft + 93*(this.radius+1) , this.marTop , parseInt(seconds%10) , cxt);

        for( let i = 0 ; i < this.balls.length ; i ++ ){
            cxt.fillStyle=this.balls[i].color;

            cxt.beginPath();
            cxt.arc( this.balls[i].x , this.balls[i].y , this.radius , 0 , 2*Math.PI , true );
            cxt.closePath();

            cxt.fill();
        }
    },

    renderDigit( x , y , num , cxt ){

        cxt.fillStyle = "#21b384";

        for( let i = 0 ; i < digit[num].length ; i ++ )
            for(let j = 0 ; j < digit[num][i].length ; j ++ )
                if( digit[num][i][j] == 1 ){
                    cxt.beginPath();
                    cxt.arc( x+j*2*(this.radius+1)+(this.radius+1) , y+i*2*(this.radius+1)+(this.radius+1) , this.radius , 0 , 2*Math.PI )
                    cxt.closePath()

                    cxt.fill()
                }
         } 

       

     },
     mounted() {
        let canvas = this.$refs.canvas;
        let context = canvas.getContext("2d");

        canvas.width = this.cWidth;
        canvas.height = this.cHeight;

        this.curShowTimeSeconds = this.getSeconds();
        let _this = this;
        setInterval(
            ()=>{
                _this.render( context );
                _this.update();
            }
            ,
            80
        
        );
     }
   }
</script>
<style lang="css">

</style>

