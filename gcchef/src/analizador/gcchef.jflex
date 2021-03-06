package analizador;

import java_cup.runtime.Symbol;
import java.util.HashMap;

class Utility {

	private static HashMap<String, Integer> keywords = new HashMap<String,Integer>() {
		{
			put("menu", sym.menu);
			put("nickname",sym.nickname);
			put("platos", sym.platos);
			put("ingredientes", sym.ingredientes);
			put("plato", sym.plato);
			put("tipo", sym.tipo);
			put("comensales", sym.comensales);
			put("tCocinado",sym.tCocinado);
			put("tPreparacion", sym.tPreparacion);
			put("tTotal", sym.tTotal);
			put("pasos", sym.pasos);
			put("introducir", sym.introducir);
			put("programar", sym.programar);
			put("sacar", sym.sacar);
			put("realizar", sym.realizar);
		}
	};

	public static Integer keyWord(String cadena) {
		if(keywords.containsKey(cadena)) {
			int keyword = keywords.get(cadena);
			return keyword;
		}
		else {
			return -1;
		}
	}

}

%%

%public

%class scanner

%standalone

%8bit

%line

%column

%cup

%state COMMENT

Comment = "/*" [^*] ~"*/" | "/*" "*"+ "/" 
ID = [a-zA-Z][a-zA-Z0-9_]*
NUMERO = [1-9][:digit:]*
CADENA = \" [a-zA-Z][a-zA-Z_ ]* \"
KEYWORD = [a-z][a-zA-Z]*
MEDIDA = "KG" | "UDS" | "G" | "L" | "CUCHARADAS" | "VASOS"
TIEMPO = "MIN" | "S" | "H"
TIPO = [A-Z]+
INVERTIR = "Si" | "No"

%%

<YYINITIAL> {

	{INVERTIR} {
		return new Symbol(sym.invertir, new String(yytext()));
	}

	{MEDIDA} {
		return new Symbol(sym.medidaIngrediente, new String(yytext()));
	}

	{TIEMPO} {
		return new Symbol(sym.medidaTiempo, new String(yytext()));
	}

	{TIPO} {
		return new Symbol(sym.nombreTipo, new String(yytext()));
	}

	{KEYWORD} {
		Integer keyword = Utility.keyWord(yytext());
		if (keyword != -1) {
			return new Symbol(keyword);
		}
		return new Symbol(sym.id, new String(yytext()));
	}

	{CADENA} {
		return new Symbol(sym.cadena, new String(yytext()));
	}

	{ID} {
		return new Symbol(sym.id, new String(yytext()));
	}

	{NUMERO} {
		return new Symbol(sym.numero, new Integer(yytext()));
	}

	":" {
		return new Symbol(sym.dospuntos);
	}

	"{" {
		return new Symbol(sym.izqLlave);
	}

	"}" {
		return new Symbol(sym.drchLlave);
	}

	";" {
		return new Symbol(sym.pcoma);
	}

	"," {
		return new Symbol(sym.coma);
	}

	"(" {
		return new Symbol(sym.izqParent);
	}
	")" {
		return new Symbol(sym.drchParent);
	}

	{Comment} {  }

	. {}

}



	



[^] | \n {}

<<EOF>> {
	return new Symbol(sym.EOF);
}

