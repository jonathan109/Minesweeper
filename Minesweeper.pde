import de.bezier.guido.*;

//Declare and initialize row and col = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

int col=20;
int row=20;
int gnumBombs=20;
int realnumbombs=0;
boolean lost =false;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
bombs=new ArrayList <MSButton>();    
buttons=new MSButton[row][col];

for(int i =0;i<row;i++){
    for(int r=0;r<col;r++){

    buttons[i][r]=new MSButton(i,r);        
    }
}
    //declare and initialize buttons
    setBombs();
}
public void setBombs()
{
   for(int i =0;i<gnumBombs;i++)
   {
   int therow=(int)(Math.random()*row);
   int thecol=(int)(Math.random()*col);
   if(bombs.contains(buttons[therow][thecol])==false)
   {

    bombs.add(buttons[therow][thecol]);
    realnumbombs+=1;
   }
   }
}

public void draw ()
{
    background(0);
    if(isWon())
        displayWinningMessage();
    if(lost==true)
        displayLosingMessage();
}
public boolean isWon()
{
    //your code here
    int cleared=0;
    for(int i =0;i<row;i++){
        for(int r=0;r<col;r++){
            if(buttons[i][r].clicked==true){
                if(!(bombs.contains(buttons[i][r])))
                cleared+=1;
            }            
        }
    }
    
    if(cleared==((col*row)-(realnumbombs))){

        return true;
    }
    return false;
}
public void displayLosingMessage()
{
    buttons[row/2][6].label="Y";
    buttons[row/2][7].label="O";
    buttons[row/2][8].label="U";
    buttons[row/2][9].label=" ";
    buttons[row/2][10].label="L";
    buttons[row/2][11].label="O";
    buttons[row/2][12].label="S";
    buttons[row/2][13].label="T";
    buttons[5][11].label="!";
    buttons[5][0].lose=true;
    buttons[5][1].lose=true;
    buttons[5][2].lose=true;
    buttons[5][4].lose=true;
    buttons[5][5].lose=true;
    buttons[5][6].lose=true;
    buttons[5][7].lose=true;
    buttons[5][8].lose=true;
    buttons[5][9].lose=true;

    for(int i =0;i<row;i++)
    {
        for(int r=0;r<col;r++)
        {  
            buttons[i][r].clicked=true;    
        }
    }
}
public void displayWinningMessage()
{
    buttons[row/2][7].setLabel("Y");
    buttons[row/2][8].setLabel("O");
    buttons[row/2][9].setLabel("U");
    buttons[row/2][10].setLabel(" ");
    buttons[row/2][11].setLabel("W");
    buttons[row/2][12].setLabel("I");
    buttons[row/2][13].setLabel("N");
    buttons[row/2][4].win=true;
    buttons[row/2][5].win=true;
    buttons[row/2][6].win=true;
    buttons[row/2][7].win=true; 
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    boolean win=false;
    boolean lose=false;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/col;
        height = 400/row;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;     
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager  
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(keyPressed==true||(mousePressed && (mouseButton == RIGHT)))
        {
            if(marked==false)
            {
                marked=true;

            }
            else if(marked==true)
            {
                marked=false;
                clicked=false;


            }


         }
         else if(bombs.contains(this))
         {

            lost=true;
         }
         else if(countBombs(r,c)>0)
         {
            label=str(countBombs(r,c));
         }
         else
         {
            for(int i=r-1;i<=r+1;i++)
            {
                for(int n=c-1;n<=c+1;n++)
                {  
                 if(isValid(i,n))
                {  
                    if(buttons[i][n].clicked==false)
                    {
                       buttons[i][n].mousePressed();
                    }
                }
                }
            }
         }
}
public void draw () 
{    
    if (marked)
    {
        fill(300);
       //label="???";
    }
    else if( clicked && bombs.contains(this) ) 
        fill(255,0,0);
    else if(clicked)
        fill( 200 );
    else if(win==true)
    {
        fill(240,230,140);


    }
    else 
        fill(255);
    if(lose==true)
    {
        fill(100,149,237);
    }

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);

    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
       if(r >-1&&r<20&&c>-1&&c<20){


        return true;
       }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
for(int i=row-1;i<=row+1;i++){
   
    for(int n=col-1;n<=col+1;n++)
    { 
       if(isValid(i,n))
        {
            if(bombs.contains(buttons[i][n]))
            {

            numBombs++;
            }
        }
    }

}

    return numBombs;
    }
}
