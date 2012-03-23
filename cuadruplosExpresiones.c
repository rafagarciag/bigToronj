int pilaOperandos [200];
int pilaOperadores[200];

int indexOperandos=0;
int indexOperadores=0;

void pushPilaOperandos(int x){
	pilaOperandos[indexOperandos]=x;
	indexOperandos++;
}

int popPilaOperandos(){
	indexOperandos--;
	return pilaOperandos[indexOperandos+1];
}

void pushPilaOperadores(int x){
	pilaOperadores[indexOperadores]=x;
	indexOperadores++;
}

int popPilaOperadores(){
	indexOperadores--;
	return pilaOperadores[indexOperadores+1]
}

int main(){
	


}
