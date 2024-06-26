/*
iMAGIC=31474314412052024
tempografico=1
tempoMaior=4
iComentario=GdeAsset49_1x4_M7_NOTRUE_morningcall
inTicksAbertura=1
iJanela1=144.0
iJanela2=1.0
iJanela3=1.0
iJanela4=10.0
iLoteP1=0.0
iLoteP2=3.0
iLoteP3=0.0
sParcial2=true
iMult2=1.0
iConferirMargem=false
; Segunda Entrada
iMAGIC2=314134777712052024
iLote2=0.0
; SMA
smaPeriod=7
smaShift=0
smaMode=0
smaPrice=2
; ATR
atrPeriod=1
; GATOR OSCILATOR
InpJawsPeriod=7
InpJawsShift=4
InpTeethPeriod=4
InpTeethShift=3
InpLipsPeriod=3
InpLipsShift=1
InpMAMethod=2
InpAppliedPrice=2
; HORÁRIO/TIME
LocalTime=2
iIniHr=9
iIniMn=10
iFnlHr=10
iFnlMn=40
iDerr=10
; DESENHO DOS PASSOS
iPBO=true
iPasso4=true
iPasso5=true
iPasso6=false
iPasso9=true
fatorATR=0.4
ifator9=1
utilGator=false
iBarraAnterior=false
; PAINEL/PANEL
TamFonte=11
Fonte=0
iFX=1.0
ShowPeriodSep=false
; CORES/COLORS
clr_buyTrend=6908265
clr_sellTrend=8388736
clr_foreground=16436871
clr_background=-1
clr_Candle_Bull=0
clr_Chart_Up=32768
clr_Candle_Bear=0
clr_Chart_Dn=255
clr_Chart_Line=-1
clr_pbackground=-1
Font1=-1
Font2=-1
Font3=-1
clr_ButtonBuy=-1
clr_BtFontBuy=-1
clr_ButtonSell=-1
clr_BtFontSell=-1
clr_ButtonClose=-1
clr_BtFontClose=-1


Beta49: colocar janela "Fator Ticks (multiplicador de ticks no passo9)" Igual no GdeAsset2.1
Quando tem esse fator, vc fala que tem erro. Que acontece na hora errada. Daí, tirei para não acontecer mais esse erro.

Beta9_alterado: também colocar janela "Fator Ticks (multiplicador de ticks no passo9)" Igual no GdeAsset2.1
Como estava sem no 49, e era para fazer similar, ficou sem. Mas posso colocar.

Beta9_alterado: Verificar Motivo que Não funcionou "Fator Fibo (multilicador de distância para Brekeven)"
O ponto 1.618 fica na distância de 0.618. O multiplicador tem que ficar com o valor da distância. Se não funcionar, preciso saber a set e a barra onde deveria ter acontecido e não aconteceu, para eu identificar o motivo. De preferência, sabendo se apareceu mensagem de erro. 


Beta9_alterado: colocar janela "Fazer saída total no ponto da Parcial com Multiplicador para a parcial" para fechar operações
Existe saída com função de saída, e existe SL e TP.
SL e TP é rápido de fazer. 
Saída parcial ou fechamento é diferente. Precisa fazer uma função de varredura, identificação, análise e tomada de decisão. Quando é coisa de 5 minutos, não cobro. Mas quando é algo que demanda mais trabalho, preciso cobrar. Porque custa o meu tempo. Foi feito o orçamento de saída parcial + trailing stop. Se eu tiver que tratar os 2 de forma separada, de 700 o valor vai ter que subir.

*/

// sem alteração em relação ao 49. Apenas preparado para alteração


//Baseado no 29

/*
Então, depois do passo2, tem que conferir se tem alguma mínima menor que o PBO1. Se tiver, cancela. É isso?
*/

/*
Parciais 1, 2 e 3 independentes
Passo 5: não pode ter fechamento dentro do range do PBO1 depois do PBO2 antes de executar.

*/
/*
Avisar:
Foram adicionados 2 fatores multiplicadores:
Multiplicador de Ticks antes do preço de entrada: este é um multiplicador de ticks para a distância dos preços de entrada. Então, ele vai verificar esse valor vezes ticks antes de atingir o preço de entrada. Assim, vc tem como testar tanto em backtest quanto em tempo real qual pegaria mais próximo do que vc gostaria.
Fator Ticks (multiplicador de ticks no Passo9) : multiplicador de ticks para distância do passo 9. O número que for colocado, vai multiplicar ticks para conferir a distância do breakeven.



*/



/*
CORREÇÕES 10/09/2023

urgente
*Passo 8 Executar a ordem 1tic antes do ponto de entrada - ok
*Passo 9 executar o breakeven quando negociar 1Tic da Maxima do candle anterior ao Candle Atual,
nas duas Entradas1 e 2. ISTO PORQUE O BETA NÃO ESTÁ EXECUTANDO, DEVERIA MANTER ABERTA A EXECUÇÃO
O BREAKEVEN ATÉ O PREÇO VOLTAR AO PONTO DE ENTRADA E FECHA A OPERAÇÃO OU FECHAR NO ESTOPE - ok
*Passo 9 altera o valor do ATR que está executando o breakeven em vez de 1 ajusta para 0,5, nas duas Entradas1 e 2.

PROPOSTA DE ALTERAÇÃO
*PASSO 5 Alterar condição de cancelamento:após confirmar pbo2, cancelar operação
se ocorrer fechamento do preço igual ou inferior a Max do Candle PBO1 na operação
de compra e o inverso na venda; após pbo2 se o preço fechar igual ou acima da mínima do PBO1 cancela a operação.
*/

/*
""COLOCAR JANELA DE PARAMETRO DE ESTOPE ex:   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Janela 1 Qtd mínima de pontos (Então não abre se a distância de stop for menor que este valor. É isso?) SIM ABRE MANTENDO A QTD MÍNIMA DE CTOS.
x Janela 2 Qtd de Lotes para a Qtd Mínima de pontos (Lote para a quantidade mínima de pontos = Lote máximo?)SIM É O LOTE MÁXIMO PERMITIDO
x Janela 3 Ajuste em contratos por oscilação. (Então se o estope calculado no Passo 4 for 40 pontos e na Janela 1=40pts, Janela 2=20cts, janela 3=3ctos de ajuste.JANELA 4 a Cada 10 pontos a mais que 40 pontos reduz 3 contratos dos 20 mínimo e assim quanto maior o Range do estope Calculado no Passo4 menor será a qtd de lotes ajustada para executar a entrada.
XJANELA 4 QTD OSCILAÇÃO EM TICS

*ACRESCENTEI A JANELA 4

*Se a distância for 40, abre com lote de 20. Se for 50, abre com lote de 17. Se for 60, abre com lote de 14. É isso? *SIM EXATAMENTE. ACRESCENTEI A JANELA ASSIM FICA AJUSTAVEL. A IDEIA É AJUSTAR UM VALOR DE PERDA MÁXIMA.



passo 10 - FEITO
alvo parcial1 ""(1xPIP DO BREAKEVEN),PARCIAL2 1.00,  PARCIAL3 novo pbo2 no sentido da operação
E, alvo final 15minFIM DO PREGÃO. )

ENTRADA LOTE2 no Ponto  -1 Acrescentar uma segunda ENTRADA o LOTE2,
na compra se executar entrada e preço negociar 1x ATR a favor da operação ou se executar entrada e negociar 1 tic da Máxima do candle anterior, no momento,
verifica  se preço esta abaixo da primeira ENTRADA, se sim Liquida operação, mas se preço estiver acima da Entrada1 arrasta Ambos os Estopes para Breakeven.
se executar primeira entrada e sinalizar Breakeven cancelar o lote2 ou liquidar e colocar todos os demais lotes em Breakeven





* Parcial 2 deixa de ser no 1.618? Passa a ser no 1.0? *SIM ALTERAR +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


Corrigir a falha dos DOJI =  if(Open[i]>Close[i] && Close[i]<sma[i] && Open[i+1]<sma[i+1] && Open[i+1]<=Close[i+1] && Open[i+2]<sma[i+2] && Close[i+2]<=Open[i+1])// && (GatilhoSell>Open[i+2] || GatilhoSell==0))
*/


#property copyright "Daniel de Almeida Galvão"
#property link      "https://www.mql5.com/pt/users/admpartinvest"
#property version   "1.50"
//#property icon "GDE_48.ico"

#property description "Toda operação daytrade ou swingtrade é de alto risco."
#property description "Não nos responsabilizamos por quaisquer prejuízos advindos do uso deste, "
#property description "ou ocasionado por imprudência ou imperícia por parte do usuário,"
#property description "bem como qualquer problema interente à plataforma ou aos servidores."
#property description "Apenas a versão oficial é garantida contra falhas de programação."


#define Nome_EA "GDE Asset"
#define  nTitulos 9

#define PrintRecado false

#define Chart1 0
#define lim1 20
#define Gaps 10
//#define lim2 6
enum ENUM_FONTE
  {
   Arial,         // Arial
   Calibri,       // Calibri
   LucidaConsole  // Lucida Console
  };


enum ENUM_HOURS
  {
   hour_00  =0,   // 00
   hour_01  =1,   // 01
   hour_02  =2,   // 02
   hour_03  =3,   // 03
   hour_04  =4,   // 04
   hour_05  =5,   // 05
   hour_06  =6,   // 06
   hour_07  =7,   // 07
   hour_08  =8,   // 08
   hour_09  =9,   // 09
   hour_10  =10,  // 10
   hour_11  =11,  // 11
   hour_12  =12,  // 12
   hour_13  =13,  // 13
   hour_14  =14,  // 14
   hour_15  =15,  // 15
   hour_16  =16,  // 16
   hour_17  =17,  // 17
   hour_18  =18,  // 18
   hour_19  =19,  // 19
   hour_20  =20,  // 20
   hour_21  =21,  // 21
   hour_22  =22,  // 22
   hour_23  =23,  // 23
  };

enum ENUM_MINUTES
  {
   min_00   =0,   // 00
   min_05   =5,   // 05
   min_10   =10,   // 10
   min_15   =15,   // 15
   min_20   =20,   // 20
   min_25   =25,   // 25
   min_30   =30,   // 30
   min_35   =35,   // 35
   min_40   =40,   // 40
   min_45   =45,   // 45
   min_50   =50,   // 50
   min_55   =55,   // 55
  };

enum ENUM_LocalTime
  {
   HoraLocal,      // Local
   HoraAbsoluta,   // GMT
   HoraCorrente    // Broker
  };

//--- input parameters
//input
bool  TesteReal = false;
input long        iMAGIC            = 7431999; // Magic
input ENUM_TIMEFRAMES tempografico = PERIOD_CURRENT;  // Tempo Gráfico
input ENUM_TIMEFRAMES tempoMaior   = PERIOD_M12; // Tempo Gráfico Maior de referência
input string      iComentario       = Nome_EA;             // Comentário das operações
input int      inTicksAbertura = 1; // Multiplicador de Ticks antes do preço de entrada
//input double iLote = 5; // Lote de entrada
input double   iJanela1 = 144; // Janela 1: Quantidade mínima de pontos
input double   iJanela2 = 3; // Janela 2: Quantidade de Lotes para Quantidade mínima de pontos
input double   iJanela3 = 1;  // Janela 3: Ajuste de contratos por oscilação
input double   iJanela4 = 10; // Janela 4: Quantidade de Oscilação em TICKS

input double iLoteP1 = 0; // Lote saída parcial 1
input double iLoteP2 = 3; // Lote saída parcial 2
input double iLoteP3 = 0; // Lote saída parcial 3
input bool     sParcial2 = true; // Fazer saída total no ponto da Parcial 2
input double iMult2  = 1.00; // Multiplicador para a parcial 2
input bool   iConferirMargem = true;   // Conferir Margem antes de operar

/*
""COLOCAR JANELA DE PARAMETRO DE ESTOPE ex:   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Janela 1 Qtd mínima de pontos (Então não abre se a distância de stop for menor que este valor. É isso?) SIM ABRE MANTENDO A QTD MÍNIMA DE CTOS.
x Janela 2 Qtd de Lotes para a Qtd Mínima de pontos (Lote para a quantidade mínima de pontos = Lote máximo?)SIM É O LOTE MÁXIMO PERMITIDO
x Janela 3 Ajuste em contratos por oscilação. (Então se o estope calculado no Passo 4 for 40 pontos e na Janela 1=40pts, Janela 2=20cts, janela 3=3ctos de ajuste.
JANELA 4 a Cada 10 pontos a mais que 40 pontos reduz 3 contratos dos 20 mínimo e assim quanto maior o Range do estope Calculado no Passo4 menor será a qtd
de lotes ajustada para executar a entrada.
XJANELA 4 QTD OSCILAÇÃO EM TICS

*ACRESCENTEI A JANELA 4

*Se a distância for 40, abre com lote de 20. Se for 50, abre com lote de 17. Se for 60, abre com lote de 14. É isso? *SIM EXATAMENTE. ACRESCENTEI A JANELA ASSIM FICA AJUSTAVEL. A IDEIA É AJUSTAR UM VALOR DE PERDA MÁXIMA.
*/

input group   "Segunda Entrada";
input long        iMAGIC2 = 7431888; // MAGIC 2
input double      iLote2   = 0; //Lote para a segunda entrada

input group    "SMA";
input int      smaPeriod = 3; // Período MA
input int      smaShift = 0; // Shift MA
input ENUM_MA_METHOD smaMode = MODE_SMA; // MA Mode
input ENUM_APPLIED_PRICE smaPrice = PRICE_OPEN; // MA Price


input group     "ATR";
input int  atrPeriod = 1;

input group "GATOR OSCILATOR";
input int                InpJawsPeriod=7;                // Jaws period
input int                InpJawsShift=4;                 // Jaws shift
input int                InpTeethPeriod=4;               // Teeth period
input int                InpTeethShift=3;                // Teeth shift
input int                InpLipsPeriod=3;                // Lips period
input int                InpLipsShift=1;                 // Lips shift
input ENUM_MA_METHOD     InpMAMethod=MODE_SMMA;          // Moving average method
input ENUM_APPLIED_PRICE InpAppliedPrice=PRICE_OPEN;     // Applied price


input group             "HORÁRIO/TIME";
input ENUM_LocalTime    LocalTime             = HoraCorrente;// Time Reference
input ENUM_HOURS        iIniHr                = hour_08;     // Start Hour
input ENUM_MINUTES      iIniMn                = min_15;      // Start Minute
input ENUM_HOURS        iFnlHr                = hour_18;     // End Hour
input ENUM_MINUTES      iFnlMn                = min_15;      // End Minute
input ENUM_MINUTES      iDerr                 = min_15;      // Minutes to Close ALL (zero = swingtrade)


input group       "DESENHO DOS PASSOS";
input bool        iPBO = true; // Mostrar linhas PBO
//input bool        iGatilhos = false; // Mostra no log os gatilhos atingidos
//input
bool        MostraGatilhos = false;// Mostra no log todos os Gatilhos (mesmo não confirmados)
input bool        iPasso4 = true;// Utilizar passo 4 (Comparação de Gatilhos e Aberturas de confirmação)
input bool        iPasso5 = true; // Utilizar passo 5 (tick além PBO1/1xATR/tick além da barra/tick abaixo 50% retração)
input bool        iPasso6 = true;   //Utilizar passo 6 (Acumulação)
//input string      iPasso7 = "Passo 7 Obrigatório";// Passo 7: Se houver novo PBO a favor, cancela operação
//input string      iPasso8 = "Passo 8 Obrigatório"; //Passo 8: Preço de abertura: conforme valores de candle e ATR
input bool        iPasso9 = true;         // Utilizar passo 9: Breakeven
input double      fatorATR = 0.4;         // Fator ATR (multiplicador do ATR no Passo9)
input int         ifator9 = 1;            // Fator Ticks (multiplicador de ticks no Passo9)
input bool        utilGator = true;       // Utilizar Gator Oscilator
input bool        iBarraAnterior = true; // Operar apenas se for 1 barra após PBO2

input group       "PAINEL/PANEL";
input int         TamFonte          = 11;                      // Font Size
input ENUM_FONTE  Fonte             = Arial ;                  // Font Name
input double      iFX               = 1.0;                     // Adjust (1=default)
input bool        ShowPeriodSep     = false;                   // Show Period Sep

input group       "CORES/COLORS";
input color       clr_buyTrend     = clrDimGray;                 // Tendência de Compra

input color       clr_sellTrend    = clrPurple;              // Tendência de Venda

input color       clr_foreground    = clrLightSkyBlue;         // Foreground
input color       clr_background    = clrBlack;                // Background
input color       clr_Candle_Bull   = clrBlack;                // Candle Bull
input color       clr_Chart_Up      = clrGreen;                // Chart Up
input color       clr_Candle_Bear   = clrBlack;                // Candle Bear
input color       clr_Chart_Dn      = clrRed;                  // Chart Down
input color       clr_Chart_Line    = clrWhite;                // Chart Line
input color       clr_pbackground   = clrBlack;                // Panel Background
input color       Font1             = clrLightBlue;            // Titles
input color       Font2             = clrWhiteSmoke;           // Standard Font
input color       Font3             = clrWhiteSmoke;           // Fonte Editáveis
input color       clr_ButtonBuy          = clrGreen;                // Button Buy
input color       clr_BtFontBuy          = clrWhite;                // Button Buy Font
input color       clr_ButtonSell         = C'255,55,55';               // Button Sell
input color       clr_BtFontSell         = clrWhite;                // Button Sell Font
input color       clr_ButtonClose        = clrMaroon;               // Button Close
input color       clr_BtFontClose        = clrWhite;                // Button Close Font


#include <Trade\Trade.mqh>
#include <Trade\SymbolInfo.mqh>
#include <Trade\AccountInfo.mqh>
CTrade         m_trade1;                      // trading object
CTrade         m_trade2;                      // trading object
CAccountInfo   m_account;                    // account info wrapper
CSymbolInfo    m_symbol;                   // symbol info object Buy

//Geral
// globais, global

datetime fim;

datetime BarraEntradaPrincipal=0;
double PrecoEntrada=0,PrecoEntrada2=0;

bool inicio=false;
double ASK=0,BID=0;
long nMAGIC,nMAGIC2;
//indicadores
int sma_handle=-1;
int atr_handle=-1;
int gator_handle = -1;

//Painel
string FONTE;



int limite1=80;
long LnB1=0;
long LnS1=0;

datetime dtBuy1=0,dtSell1=0;
datetime TPBOBuyEntrada=0,TPBOSellEntrada=0;

int Trend1=0;
int aTrend1=0;
double Ponto1=0,Ponto2=0,D12=0;
string ValorPasso4="-";
string ValorPasso5="-";
string ValorPasso6="-";
string ValorPasso7="-";
bool Cancelou5=false;
bool Cancelou4=false;
bool Cancelou7=false;
bool Cancelou6=false;
bool cancelou=false;
double High1=0,Low1=0;

double UltimoGatilhoCompraConfirmado=0,UltimoGatilhoVendaConfirmado=0;
double GatilhoPBO1=0,GatilhoPBO2=0;
datetime TPBOBuy[3],TPBOSell[3];
double Preco50=0,oPreco50=0;
//double PrecoAberturaBuy=0,PrecoAberturaSell=0;//Passo8
double PrecoAberturaBuy0=0,PrecoAberturaSell0=0;//Passo8
double StopInicial0buy=0;//passou a ser no ponto -1,1618 no txt4
double StopInicial1buy=0;//passou a ser no ponto -1,1618 no txt4
double StopInicial0sell=0;//passou a ser no ponto -1,1618 no txt4
double StopInicial1sell=0;//passou a ser no ponto -1,1618 no txt4
double //Preco1618=0,
Preco100=0,Precon1=0,oPreco100=0;

//Operações
double LoteComprado=0,LoteVendido=0;
double LoteComprado2=0,LoteVendido2=0;
double PassoVolume=0;
int dVol=0;
double dLote0=0,dLote1=0,dLoteP1=0,dLoteP2=0,dLoteP3=0;
double dLote2=0;
//Garantir que cada Parcial aconteça apenas 1x
bool Part1=false,Part2=false,Part3=false,Operou1=false,Operou2=false;

double divSymbol=0,Espaco=0;//,OffSet=0,BE=0;
//string TTMargem="";

double LucroAbertas=0;
bool     DeveSairCompra=false,DeveSairVenda=false,Prossegue=false;

datetime dAgora;
MqlDateTime mdt1,mdt2;
long lAgora,Hoje,Ontem=0;
long Iniciar,Finalizar,Derrubar;
string dHoje,dHojeBroker;
bool funciona = false;

int iExp=0;
double HighPBO1=0,LowPBO1=0;


string p_Nome_EA, p_Magic, p_Comment, p_Positions_Profit, p_Buy_Lot, p_Sell_Lot, p_Profit_Today, p_Profit, p_Habilitado;
//double LoteComprado=0,LoteVendido=0,LucroAbertas=0;
double LucroDia=0,LucroTotal=0;
string Recado="";
double atrpbo=0;
int fator9 = 1;
int nTicksAbertura = 1;
double VolumeMinimo = 0;

//datetime TimePBO1,TimePBO2;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   inicio=false;



   CalculaHorario();
   InicializaValores();
   Indicadores();
   DesenhaPainel();


//EventSetTimer(60);

   AjustaImediato();
   static datetime prev_time1;
   double O=0,H=0,L=0,C=0;
   atrpbo=0;
   bool Cancela=false;
   for(int i=lim1; i>=0; i--)
     {
      prev_time1=iTime(Symbol(),tempografico,i);
      Cancela=RodaPBO(i,prev_time1,O,H,L,C,atrpbo);
     }
   if(H>0 && L>0 && !Cancelou4)
     {
      Retracao(Trend1,O,H,L,C,atrpbo);//Passo3 e Passo8
      High1=H;
      Low1=L;
      fPasso5();
     }
// if(H>0 && L>0 && !Cancela)      Retracao(Trend1,H,L);//Passo3

//Indicadores();
   inicio=true;

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   /*
   //--- destroy timer

    EventKillTimer();

    ObjectsDeleteAll(0);
    LimpaIndicadores(0);
   */
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---


   if(!inicio)
      return;

// if(!trade_session())      return;

// if(!RefreshRates())      return;


   Agora();


   AjustaImediato();

   if(DeveSairCompra || DeveSairVenda)
     {

      if(!trade_session())
         return;

      if(!RefreshRates())
         return;
      //if(VerificaFinal)         Print("DeveSairCompra=",DeveSairCompra,", DeveSairVenda=",DeveSairVenda);

      if(DeveSairCompra)
        {
         if(LoteComprado>0)
            ArrastaSLgrudado(1);
         else
            DeveSairCompra=false;
        }

      if(DeveSairVenda)
        {
         if(LoteVendido>0)
            ArrastaSLgrudado(-1);
         else
            DeveSairVenda=false;

        }
      return;
     }


   if(LoteComprado+LoteVendido>0 || !funciona)
     {
      if(!TesteReal)
        {
         VerificaStops();

        }

     }

   if(funciona && LoteComprado+LoteVendido>0 && !TesteReal)
      VerificaEntrada2();

   static datetime prev_time1=0;
   if(prev_time1!=iTime(Symbol(),tempografico,0)) // Virada tempografico
     {
      prev_time1=iTime(Symbol(),tempografico,0);

      double O=0,H=0,L=0,C=0;
      atrpbo=0;
      Cancelou4 = RodaPBO(0,prev_time1,O,H,L,C,atrpbo);//Cancelamento é o Passo4
      if(Cancelou4)
        {
         PrecoAberturaBuy0=0;
         PrecoAberturaSell0=0;
        }
      if(H>0 && L>0 && !Cancelou4 && funciona)
        {
         Retracao(Trend1,O,H,L,C,atrpbo);//Passo3 e Passo8
         High1=H;
         Low1=L;
         fPasso5();
        }


     }

   if(!TesteReal)
      if(trade_session() && RefreshRates())
        {
         if(!funciona)
            return;

         Decisao();
        }

   static datetime prev_timeM1=0;
   if(prev_timeM1!=iTime(Symbol(),PERIOD_M1,0)) // Virada Minuto
     {
      prev_timeM1=iTime(Symbol(),PERIOD_M1,0);

      if(LoteComprado2+LoteVendido2==0 && Operou2)
         Operou2=false;
      /*
      if(utilGator){
         double gator0[1],gator1[1],gator2[1],gator3[1];
      CopyBuffer(gator_handle,0,0,1,gator0);
      CopyBuffer(gator_handle,1,0,1,gator1);
      CopyBuffer(gator_handle,2,0,1,gator2);
      CopyBuffer(gator_handle,3,0,1,gator3);
      string cor1,cor2;
      if(gator1[0]==1)cor1="vermelho";
      else cor1="verde";
      if(gator3[0]==1)cor2="vermelho";
      else cor2="verde";

         Print("Gator0=",gator0[0],", gator1=",cor1,", gator2=",gator2[0],", gator3=",cor2);
         //vermelho = 1
         //verde = 0
      }
      */
      if(TesteReal)
        {
         if(!trade_session())
            return;

         if(!RefreshRates())
            return;

         if(LoteComprado+LoteVendido>0)// || !funciona)
           {
            VerificaStops();
            if(funciona)
               VerificaEntrada2();
            return;
           }

         if(!funciona)
            return;

         Decisao();
        }

     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Decisao()
  {
   bool podeOperar=true;


   if(!Cancelou5 && !Cancelou4 && ((PrecoAberturaBuy0>0 && Trend1==1) || (PrecoAberturaSell0>0 && Trend1==-1)))
     {
      if(utilGator)
        {
         //double gator0[1],gator1[1],gator2[1],gator3[1];
         double gator1[1],gator3[1];
         //CopyBuffer(gator_handle,0,0,1,gator0);
         CopyBuffer(gator_handle,1,0,1,gator1);
         //CopyBuffer(gator_handle,2,0,1,gator2);
         CopyBuffer(gator_handle,3,0,1,gator3);
         //vermelho = 1
         //verde = 0
         podeOperar=false;
         if(gator1[0]==gator3[0])
           {
            if(gator1[0]==0 && Trend1==1)//verde + tendencia de compra
               podeOperar=true;
            if(gator1[0]==1 && Trend1==-1)//vermelho + tendência de venda
               podeOperar=true;
           }
         if(!podeOperar)
            return;
        }

      if(StopInicial0buy>0)
        {
         Espaco      = MathCeil((SymbolInfoInteger(Symbol(),SYMBOL_TRADE_FREEZE_LEVEL)+SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL))*_Point/divSymbol)*divSymbol + 2*divSymbol;
         if(Trend1==1 && aTrend1!=1 && !Operou1)
           {

            if(ASK<=PrecoAberturaBuy0+divSymbol*nTicksAbertura && StopInicial0buy<ASK-Espaco)
              {
               fPasso6();
               bool f_anterior=fAnterior();
               if(!Cancelou6 && f_anterior)
                 {
                  ASK=MathCeil(ASK/divSymbol)*divSymbol;
                  ASK=NormalizeDouble(ASK,_Digits);
                  StopInicial1buy=MathFloor(StopInicial0buy/divSymbol)*divSymbol;
                  StopInicial1buy=NormalizeDouble(StopInicial1buy,_Digits);

                  /*if(ASK-StopInicial<atrpbo*2)
                    {
                     Recado="Stop muito curto!";
                     //Print(Recado);
                     return;
                    }*/
                  dLote1=dLote0;
                  double TP=0.0;//MathFloor((ASK+1000)/divSymbol)*divSymbol;
                  TP=NormalizeDouble(TP,_Digits);

                  dLoteP1=MathCeil(iLoteP1/PassoVolume)*PassoVolume;
                  if(dLoteP1>=dLote1)
                    {
                     dLoteP1=MathFloor(iLoteP1/PassoVolume)*PassoVolume;
                     if(dLoteP1>=dLote1)
                        dLoteP1=0;
                    }

                  dLoteP2=MathCeil(iLoteP2/PassoVolume)*PassoVolume;
                  if(dLoteP2>=dLote1)
                    {
                     dLoteP2=MathFloor(iLoteP2/PassoVolume)*PassoVolume;
                     if(dLoteP2>=dLote1)
                        dLoteP2=0;
                    }

                  dLoteP3=MathCeil(iLoteP3/PassoVolume)*PassoVolume;
                  if(dLoteP3>=dLote1)
                    {
                     dLoteP3=MathFloor(iLoteP3/PassoVolume)*PassoVolume;
                     if(dLoteP3>=dLote1)
                        dLoteP3=0;
                    }
                  if(CheckMoneyForTrade(Symbol(),ORDER_TYPE_BUY,dLote1))
                    {
                     if(!m_trade1.Buy(dLote1,Symbol(),ASK,StopInicial1buy,TP,iComentario))
                       {
                        Recado="Falhou ordem de compra. Preço:"+DoubleToString(ASK,_Digits)+", SL:"+DoubleToString(StopInicial1buy,_Digits)+", TP:"+DoubleToString(TP,_Digits);
                        if(PrintRecado)
                           Print(Recado);
                       }
                     else
                       {
                       oPreco50=Preco50;
                       oPreco100=Preco100;
                        Operou2=false;
                        TPBOBuyEntrada=TPBOBuy[2];//0,TPBOSellEntrada=0;
                        BarraEntradaPrincipal=iTime(m_symbol.Name(),tempografico,0);
                        Part1=false;
                        Part2=false;
                        Part3=false;
                        Operou1=true;
                       }
                    }
                 }
              }
           }
        }
      if(StopInicial0sell>0)
        {
         if(Trend1==-1 && aTrend1!=-1 && !Operou1)
           {
            if(BID>=PrecoAberturaSell0-divSymbol*nTicksAbertura && StopInicial0sell>BID+Espaco)
              {
               fPasso6();
               bool f_anterior=fAnterior();
               if(!Cancelou6 && f_anterior)
                 {
                  BID=MathFloor(BID/divSymbol)*divSymbol;
                  BID=NormalizeDouble(BID,_Digits);
                  StopInicial1sell=MathFloor(StopInicial0sell/divSymbol)*divSymbol;
                  StopInicial1sell=NormalizeDouble(StopInicial1sell,_Digits);
                  double TP=0.0;//MathFloor((BID-1000)/divSymbol)*divSymbol;
                  TP=NormalizeDouble(TP,_Digits);
                  /*if(StopInicial-BID<atrpbo*2){
                  Recado="Stop muito curto!";
                     Print(Recado);
                     return;}
                     */
                  dLote1=dLote0;

                  dLoteP1=MathCeil(iLoteP1/PassoVolume)*PassoVolume;
                  if(dLoteP1>=dLote1)
                    {
                     dLoteP1=MathFloor(iLoteP1/PassoVolume)*PassoVolume;
                     if(dLoteP1>=dLote1)
                        dLoteP1=0;
                    }

                  dLoteP2=MathCeil(iLoteP2/PassoVolume)*PassoVolume;
                  if(dLoteP2>=dLote1)
                    {
                     dLoteP2=MathFloor(iLoteP2/PassoVolume)*PassoVolume;
                     if(dLoteP2>=dLote1)
                        dLoteP2=0;
                    }

                  dLoteP3=MathCeil(iLoteP3/PassoVolume)*PassoVolume;
                  if(dLoteP3>=dLote1)
                    {
                     dLoteP3=MathFloor(iLoteP3/PassoVolume)*PassoVolume;
                     if(dLoteP3>=dLote1)
                        dLoteP3=0;
                    }
                  if(CheckMoneyForTrade(Symbol(),ORDER_TYPE_SELL,dLote1))
                    {
                     if(!m_trade1.Sell(dLote1,Symbol(),BID,StopInicial1sell,TP,iComentario))
                       {
                        Recado="Falhou ordem de venda. Preço:"+DoubleToString(ASK,_Digits)+", SL:"+DoubleToString(StopInicial1sell,_Digits)+", TP:"+DoubleToString(TP,_Digits);
                        if(PrintRecado)
                           Print(Recado);
                       }
                     else
                       {
                       
                       oPreco50=Preco50;
                       oPreco100=Preco100;
                        TPBOSellEntrada=TPBOSell[2];
                        BarraEntradaPrincipal=iTime(m_symbol.Name(),tempografico,0);
                        Part1=false;
                        Part2=false;
                        Part3=false;
                        Operou1=true;
                        Operou2=false;
                       }
                    }
                 }
              }
           }
        }

     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void VerificaEntrada2()
  {
   if(dLote2==0 || Operou2)
      return;
   datetime BarraAtual=iTime(m_symbol.Name(),tempografico,0);

   if(BarraAtual<BarraEntradaPrincipal)
      return;
   if(LoteComprado>0)
     {
      if(LoteComprado2>0)//já fez Entrada2
        {
         /*   e preço negociar 1x ATR a favor da operação ou se executar entrada e negociar 1 tic da Máxima do candle anterior, no momento,
         verifica  se preço esta abaixo da primeira ENTRADA, se sim Liquida operação, mas se preço estiver acima da Entrada1 arrasta Ambos os Estopes para Breakeven.
         se executar primeira entrada e sinalizar Breakeven cancelar o lote2 ou liquidar e colocar todos os demais lotes em Breakeven */
         double ATR[1];
         CopyBuffer(atr_handle,0,0,1,ATR);
         double High0=iHigh(m_symbol.Name(),tempografico,0);
         double High_1=iHigh(m_symbol.Name(),tempografico,1);
         if(High0>=PrecoEntrada2+(ATR[0]*fatorATR) || High0>=High_1-divSymbol)
           {
            if(ASK<PrecoEntrada)
               FechaTudo();
            if(ASK>PrecoEntrada)
              {
               BreakEvenTotal();
              }
           }
         return;
        }
      if(ASK<=Precon1)
        {
         Espaco      = MathCeil((SymbolInfoInteger(Symbol(),SYMBOL_TRADE_FREEZE_LEVEL)+SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL))*_Point/divSymbol)*divSymbol + 2*divSymbol;
         ASK=MathCeil(ASK/divSymbol)*divSymbol;
         ASK=NormalizeDouble(ASK,_Digits);
         if(ASK-StopInicial1buy<=Espaco || ASK<StopInicial1buy)
           {
            Recado="Entrada 2 impossível: Stop muito curto.";
            if(PrintRecado)
               Print(Recado);
            return;
           }
         Operou2=true;
         //fazer Entrada2
         if(CheckMoneyForTrade(Symbol(),ORDER_TYPE_BUY,dLote2))
           {
            if(!m_trade2.Buy(dLote2,m_symbol.Name(),ASK,StopInicial1buy,0,iComentario+"2"))
              {
               Recado="Falha ao executar Entrada2.";
               if(PrintRecado)
                  Print(Recado);
              }
            else
              {
               Recado="Entrada2 ok.";
               if(PrintRecado)
                  Print(Recado);
              }
           }
        }
     }
   if(LoteVendido>0)
     {
      if(LoteVendido2>0)//já fez Entrada2
        {
         double ATR[1];
         CopyBuffer(atr_handle,0,0,1,ATR);
         double Low0=iLow(m_symbol.Name(),tempografico,0);
         double Low_1=iLow(m_symbol.Name(),tempografico,1);
         if(Low0<=PrecoEntrada2-(ATR[0]*fatorATR) || Low0<=Low_1+divSymbol)
           {
            if(BID>PrecoEntrada)
               FechaTudo();
            if(BID<PrecoEntrada)
              {
               BreakEvenTotal();
              }
           }
         return;
        }
      Operou2=true;
      if(BID>=Precon1)
        {
         Espaco      = MathCeil((SymbolInfoInteger(Symbol(),SYMBOL_TRADE_FREEZE_LEVEL)+SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL))*_Point/divSymbol)*divSymbol + 2*divSymbol;
         BID=MathFloor(BID/divSymbol)*divSymbol;
         BID=NormalizeDouble(BID,_Digits);
         if(StopInicial1sell-BID<=Espaco || BID>StopInicial1sell)
           {
            Recado="Entrada 2 impossível: Stop muito curto.";
            if(PrintRecado)
               Print(Recado);
            return;
           }
         //Fazer Entrada2
         if(CheckMoneyForTrade(Symbol(),ORDER_TYPE_BUY,dLote2))
           {
            if(!m_trade2.Buy(dLote2,m_symbol.Name(),BID,StopInicial1sell,0,iComentario+"2"))
              {
               Recado="Falha ao executar Entrada2.";
               if(PrintRecado)
                  Print(Recado);
              }
            else
              {
               Recado="Entrada2 ok.";
               if(PrintRecado)
                  Print(Recado);
              }
           }
        }

     }
//BarraEntradaPrincipal


   /*
   ENTRADA LOTE2 no Ponto  -1 Acrescentar uma segunda ENTRADA o LOTE2,
   na compra se executar entrada

   e preço negociar 1x ATR a favor da operação ou se executar entrada e negociar 1 tic da Máxima do candle anterior, no momento,
   verifica  se preço esta abaixo da primeira ENTRADA, se sim Liquida operação, mas se preço estiver acima da Entrada1 arrasta Ambos os Estopes para Breakeven.
   se executar primeira entrada e sinalizar Breakeven cancelar o lote2 ou liquidar e colocar todos os demais lotes em Breakeven
   */



  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void BreakEvenTotal()
  {
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong    position_ticket   = PositionGetTicket(i);                // bilhete da posição
      long     Pmagic            = PositionGetInteger(POSITION_MAGIC);  // MagicNumber da posição
      string   PAberta           = PositionGetSymbol(i);
      long     TipoOrdem         = PositionGetInteger(POSITION_TYPE);   // Tipo
      double   precoEntrada      = PositionGetDouble(POSITION_PRICE_OPEN);
      double   Volume            = PositionGetDouble(POSITION_VOLUME);
      double   SL                = PositionGetDouble(POSITION_SL);
      double   TP                = PositionGetDouble(POSITION_TP);
      if((Pmagic == nMAGIC || Pmagic == nMAGIC2) && PAberta==m_symbol.Name())
        {
         if(TipoOrdem == POSITION_TYPE_BUY)
           {
            if(SL<precoEntrada && ASK>precoEntrada+Espaco)
              {
               double novoSL=MathFloor(precoEntrada/divSymbol)*divSymbol;
               novoSL=NormalizeDouble(novoSL,_Digits);
               if(novoSL!=SL)
                 {
                  if(nMAGIC==Pmagic)
                     if(!m_trade1.PositionModify(position_ticket,novoSL,TP))
                       {
                        Recado="Falhou Breakeven ordem "+IntegerToString(position_ticket);
                        if(PrintRecado)
                           Print(Recado);
                       }
                  if(nMAGIC2==Pmagic)
                     if(!m_trade2.PositionModify(position_ticket,novoSL,TP))
                       {
                        Recado="Falhou Breakeven ordem "+IntegerToString(position_ticket);
                        if(PrintRecado)
                           Print(Recado);
                       }
                 }
              }
           }
         if(TipoOrdem == POSITION_TYPE_SELL)
           {
            if(SL>precoEntrada && BID<precoEntrada+-Espaco)
              {
               double novoSL=MathFloor(precoEntrada/divSymbol)*divSymbol;
               novoSL=NormalizeDouble(novoSL,_Digits);
               if(novoSL!=SL)
                 {
                  if(nMAGIC==Pmagic)
                     if(!m_trade1.PositionModify(position_ticket,novoSL,TP))
                       {
                        Recado="Falhou Breakeven ordem "+IntegerToString(position_ticket);
                        if(PrintRecado)
                           Print(Recado);
                       }
                  if(nMAGIC2==Pmagic)
                     if(!m_trade2.PositionModify(position_ticket,novoSL,TP))
                       {
                        Recado="Falhou Breakeven ordem "+IntegerToString(position_ticket);
                        if(PrintRecado)
                           Print(Recado);
                       }
                 }
              }
           }
        }

     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void VerificaStops()
  {

   if(!trade_session())
      return;

   if(!RefreshRates())
      return;

//Espaco      = MathCeil((SymbolInfoInteger(Symbol(),SYMBOL_TRADE_FREEZE_LEVEL)+SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL))*_Point/divSymbol)*divSymbol + 2*divSymbol;

   double ATR1[1];
   CopyBuffer(atr_handle,0,0,1,ATR1);
   if(ATR1[0]<=0)
      return;
   double low1 = iLow(Symbol(),tempografico,1);
   double high1 = iHigh(Symbol(),tempografico,1);
   double low0 = iLow(Symbol(),tempografico,0);
   double high0 = iHigh(Symbol(),tempografico,0);

   Espaco      = MathCeil((SymbolInfoInteger(Symbol(),SYMBOL_TRADE_FREEZE_LEVEL)+SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL))*_Point/divSymbol)*divSymbol;// + 2*divSymbol;
   double nPrecoSL=0;
   double preco=0,preco0=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong    position_ticket   = PositionGetTicket(i);                // bilhete da posição
      long     Pmagic            = PositionGetInteger(POSITION_MAGIC);  // MagicNumber da posição
      string   PAberta           = PositionGetSymbol(i);
      long     TipoOrdem         = PositionGetInteger(POSITION_TYPE);   // Tipo
      double   precoEntrada      = PositionGetDouble(POSITION_PRICE_OPEN);
      double   Volume            = PositionGetDouble(POSITION_VOLUME);
      double   SL                = PositionGetDouble(POSITION_SL);
      double   TP                = PositionGetDouble(POSITION_TP);
      if(Pmagic == nMAGIC && PAberta==m_symbol.Name())
        {

         if(TipoOrdem == POSITION_TYPE_BUY)
           {
            preco=BID;
            preco0 = high0;
            if(iPasso9)
              {
               Print("Passou no passo 9 [1]",oPreco50);
               //if(preco>=precoEntrada+(ATR1[0]*fatorATR) || preco0>=high1 || preco0>=oPreco50)//-divSymbol*fator9)
               if(preco>=precoEntrada+(ATR1[0]*fatorATR) || preco0>=high1-divSymbol*fator9 || preco0>=oPreco50)//-divSymbol*fator9)
                 {
                  nPrecoSL=NormalizeDouble(precoEntrada,m_symbol.Digits());
                  //if(VerificaFinal)               Print("Novosl=",PrecoSL);
                  if(nPrecoSL<BID-Espaco && nPrecoSL>=SL+Espaco && SL!=precoEntrada)// || SL==0))
                    {
                     if(!m_trade1.PositionModify(position_ticket,nPrecoSL,TP))
                       {
                        Recado="Falhou Breakeven. [9]";// Order: "+IntegerToString(position_ticket);
                        if(PrintRecado)
                           Print(Recado);
                       }
                     else
                       {
                        Recado="Breakeven ok.";
                        if(PrintRecado)
                           Print(Recado);
                        //Print(Recado,",Part1= ",Part1,", dLoteP1=",dLoteP1,", volume=", Volume,", minimo=",VolumeMinimo);
                       }
                     if(dLoteP1>0 && Volume>=dLoteP1+VolumeMinimo && !Part1)// Passo10_1
                        if(!m_trade1.PositionClosePartial(position_ticket,dLoteP1))
                          {
                           Recado="Falhou Saída Parcial 1.";
                           if(PrintRecado)
                              Print(Recado);
                          }
                        else
                          {
                           Part1=true;
                           Recado="Parcial 1 ok.";
                           if(PrintRecado)
                              Print(Recado);
                          }
                    }
                 }
              }
            //Passo10_2
            //if(Volume>=(dLote-dLoteP1) && dLoteP2>0 && BID>Preco1618 && !Part2)
            if(sParcial2)
              {
               if(BID>Preco100)
                 {
                  Recado="Fechamento no ponto da parcial 2.";
                  if(PrintRecado)
                     Print(Recado);
                  FechaTudo();
                  break;
                 }
              }
            else
              {
               if((Volume>=(dLoteP2+VolumeMinimo) && dLoteP2>0 && BID>Preco100 && !Part2))
                 {
                  if(!m_trade1.PositionClosePartial(position_ticket,dLoteP2))
                    {
                     Recado="Falhou Saída Parcial 2.";
                     if(PrintRecado)
                        Print(Recado);
                    }
                  else
                    {
                     Part2=true;

                     Recado="Parcial 2 ok.";
                     if(PrintRecado)
                        Print(Recado);
                    }
                 }
              }
            //if(Volume>=dLote1-dLoteP1-dLoteP2 && Trend1==-1 && TPBOBuyEntrada<TPBOBuy[2] && dLoteP3>0 && !Part3)
            if(Volume>=dLoteP3+VolumeMinimo && Trend1==1 && TPBOBuyEntrada<TPBOBuy[2] && dLoteP3>0 && !Part3)
              {
               if(!m_trade1.PositionClosePartial(position_ticket,dLoteP3))
                 {
                  Recado="Falhou Saída Parcial 3.";
                  if(PrintRecado)
                     Print(Recado);
                 }
               else
                 {
                  Part3=true;
                  Recado="Parcial 3 ok.";
                  if(PrintRecado)
                     Print(Recado);
                 }
              }
           }
         if(TipoOrdem == POSITION_TYPE_SELL)
           {
            preco=ASK;
            preco0 = low0;
            if(iPasso9)
              {
              Print("Passou no passo 9 [2]",oPreco50,", low0=",low0,", low1=",low1);
              //if(preco>precoEntrada+(ATR1[0]*fatorATR) || preco0>=high1-divSymbol*fator9 || preco0>oPreco50-divSymbol*fator9)
               if(preco<=precoEntrada-(ATR1[0]*fatorATR) || preco0<=low1+divSymbol*fator9 || preco0<=oPreco50)//+divSymbol*fator9)
                 {
                  nPrecoSL=NormalizeDouble(precoEntrada,m_symbol.Digits());
                  //if(VerificaFinal)               Print("Novosl=",PrecoSL);
                  if(nPrecoSL>ASK+Espaco && nPrecoSL<=SL-Espaco && SL!=precoEntrada)// || SL==0))
                    {
                     if(!m_trade1.PositionModify(position_ticket,nPrecoSL,TP))
                       {
                        Recado="Falhou Breakeven. [10]";// Order: "+IntegerToString(position_ticket);
                        if(PrintRecado)
                           Print(Recado);
                       }
                     else
                       {
                        Recado="Breakeven ok.";
                        if(PrintRecado)
                           Print(Recado);
                        //Print(Recado);
                        //Print(Recado,",Part1= ",Part1,", dLoteP1=",dLoteP1,", volume=", Volume,", minimo=",VolumeMinimo);
                       }
                     if(dLoteP1>0 && Volume>=dLoteP1+VolumeMinimo && !Part1)// Passo10_1
                        if(!m_trade1.PositionClosePartial(position_ticket,dLoteP1))
                          {
                           Recado="Falhou Saída Parcial 1";
                           if(PrintRecado)
                              Print(Recado);
                           //Print(Recado);
                          }
                        else
                          {
                           Part1=true;
                           Recado="Parcial 1 ok.";
                           if(PrintRecado)
                              Print(Recado);
                           //Print(Recado);
                          }
                    }
                 }
              }
            //Passo10_2
            //if(Volume>=(dLote-dLoteP1) && dLoteP2>0 && ASK<Preco1618 && !Part2)
            if(sParcial2)
              {
               if(ASK<Preco100)
                 {
                  Recado="Fechamento no ponto da parcial 2.";
                  if(PrintRecado)
                     Print(Recado);
                  FechaTudo();
                  break;
                 }
              }
            else
              {
               if((Volume>=(dLoteP2+VolumeMinimo) && dLoteP2>0 && ASK<Preco100 && !Part2))
                 {
                  if(!m_trade1.PositionClosePartial(position_ticket,dLoteP2))
                    {
                     Recado="Falhou Saída Parcial 2.";
                     if(PrintRecado)
                        Print(Recado);
                     //Print(Recado);
                    }
                  else
                    {
                     Part2=true;
                     Recado="Parcial 2 ok.";
                     if(PrintRecado)
                        Print(Recado);
                     //Print(Recado);
                    }
                 }
              }
            //if(Volume>=dLote1-dLoteP1-dLoteP2 && Trend1==-1 && TPBOSellEntrada<TPBOSell[2] && dLoteP3>0 && !Part3)
            if(Volume>=dLoteP3+VolumeMinimo && Trend1==-1 && TPBOSellEntrada<TPBOSell[2] && dLoteP3>0 && !Part3)
              {
               if(!m_trade1.PositionClosePartial(position_ticket,dLoteP3))
                 {
                  Recado="Falhou Saída Parcial 3.";
                  if(PrintRecado)
                     Print(Recado);
                  //Print(Recado);
                 }
               else
                 {
                  Part3=true;
                  Recado="Parcial 3 ok.";
                  if(PrintRecado)
                     Print(Recado);
                  //Print(Recado);
                 }
              }
           }
        }
     }

   /*
      passo 10
      alvo parcial em 1.618 e alvo final novo pbo2 no sentido da operação.
      Quando o preço atingir o ponto 1.618, realiza a saída parcial e quando acontecer um PBO para o mesmo lado da operação, fecha a operação aberta?
      passo 10
      alvo parcial1 ""(1xPIP DO BREAKEVEN),PARCIAL2 1.618,  PARCIAL3 novo pbo2 no sentido da operação E, alvo final 15minFIM DO PREGÃO.
      */
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void fPasso6()//Passo6: Acumulação
  {

   if(!iPasso6)
     {
      return;
     }
   double ATR3[3];
   CopyBuffer(atr_handle,0,1,3,ATR3);

//if(ATR3[0]>=ATR3[1] && ATR3[1]>=ATR3[2])
   if(ATR3[1]>=ATR3[2])
     {

      Cancelou6=true;
     }

   if(Cancelou6)
      ValorPasso6="Cancelado";
   else
      ValorPasso6="-";


  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool fAnterior()
  {
   bool RetVal=true;
   int nbars=0;
   if(iBarraAnterior)
     {
      if(Trend1==1)
        {
         nbars=Bars(m_symbol.Name(),tempografico,TPBOBuy[2],iTime(m_symbol.Name(),tempografico,0));
         //Print("TPBOBuy[2]=",TPBOBuy[2], ", nBars=",nbars);
         //if(nbars==2)
         if(nbars>1)
            RetVal=false;
        }

      if(Trend1==-1)
        {
         nbars=Bars(m_symbol.Name(),tempografico,TPBOSell[2],iTime(m_symbol.Name(),tempografico,0));
         //Print("TPBOSell[2]=",TPBOSell[2], ", nBars=",nbars);
         //if(nbars==2)
         if(nbars>1)
            RetVal=false;
        }
     }
   return RetVal;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void fPasso5()//Passo5
  {
   if(!iPasso5)
      return;
   if(Low1<=0 || High1<=0)
     {
      Cancelou5=false;
      ValorPasso5="-";
      return;
     }

   /*
   PASSO 5 Alterar condição de cancelamento:após confirmar pbo2, cancelar operação
   se ocorrer fechamento do preço igual ou inferior a Max do Candle PBO1 na operação
   de compra e o inverso na venda; após pbo2 se o preço fechar igual ou acima da mínima do PBO1 cancela a operação.

   HighPBO1 = High;
   LowPBO1= Low;
   como era:
   "TESTE NA ABERTURA DO CANDLE PBO1" no momento da abertura da operação, conferir se; na compra se preço negociar
    1tic acima da DA OPEN CANDLE pbo1 e, negociar 1x ATR a favor da operação ou negociar 1 tic acima do OPEN CANDLE pbo1
    e negociar 1 tic da Máxima do candle anterior ou negociar 1 tic acima DA OPEN pbo1 e negociar 1 tic abaixo de 50% da retração Cancela a Operação


    * ALTERADO PARA: depois do passo2, tem que conferir se tem alguma mínima menor que o PBO1. Se tiver, cancela. *

    TPBOBuy[2] e TPBOSell[2]

    LowPBO1
   */
   Cancelou5=false;
   ValorPasso5="-";
   int nBar1=0;//Bars(Symbol(),PERIOD_M1,)
   int nBartf=0;
   double HighM1[],LowM1[],ATR[],Hightf[],Lowtf[];//,Closef[];
//double HighM1[],LowM1[],Closef[];
   bool Negociou1tick=false;
   double Referencia=0;
   if(Trend1==1)
     {
      nBartf=Bars(Symbol(),tempografico,TPBOSell[2],TPBOBuy[2]);
      ArrayResize(Lowtf,nBartf);
      CopyLow(Symbol(),tempografico,TPBOBuy[2],nBartf,Lowtf);

      /* datetime Datas[];
       ArrayResize(Datas,nBartf);
       CopyTime(Symbol(),tempografico,TPBOBuy[2],nBartf,Datas);*/
      for(int i=1; i<nBartf; i++)
        {
         //if(i<nBartf-1 && Closef[i]<=HighPBO1 && Closef[i]>=LowPBO1)
         if(Lowtf[i]<LowPBO1)// && Closef[i]>=LowPBO1)
           {
            Cancelou5=true;
            ValorPasso5="Cancelado";
            //Print("trend=",Trend1,", LowPBO1= ",LowPBO1,", Data[",i,"]=",Datas[i],", Lowtf[",i,"]=",Lowtf[i]);
            break;
           }
        }
     }
   if(Trend1==-1)
     {
      nBartf=Bars(Symbol(),tempografico,TPBOBuy[2],TPBOSell[2]);
      ArrayResize(Hightf,nBartf);
      CopyHigh(Symbol(),tempografico,TPBOSell[2],nBartf,Hightf);
      /* datetime Datas[];
       ArrayResize(Datas,nBartf);
       CopyTime(Symbol(),tempografico,TPBOSell[2],nBartf,Datas);*/
      //CopyClose(Symbol(),tempografico,0,nBar1,Closef);
      //CopyBuffer(atr_handle,0,0,nBar1,ATR);
      for(int i=0; i<nBartf; i++)
        {
         //if(i<nBartf-1 && Closef[i]<=HighPBO1 && Closef[i]>=LowPBO1)//Closef[i]>=LowPBO1)
         if(Hightf[i]>HighPBO1)
           {
            Cancelou5=true;
            ValorPasso5="Cancelado";
            //Print("trend=",Trend1,", HighPBO1=", HighPBO1,", Data[",i,"]=",Datas[i],", Hightf[",i,"]=",Hightf[i]);
            break;
           }

        }
     }
//Print("Passo 5 = ",ValorPasso5,", trend=",Trend1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Retracao(int Tendencia,double O,double H,double L,double C,double ATRpbo)//Passo3 //Passo8
  {

//Print("H=",H,", L=",L);
//posicionamento da retração no ponto maximo e minimo do candle que confirma pbo1 (0, entrada, 1.618 alvo, 0.5 breakeven, -1 estope)

   int Chart=0;

   Ponto1=0;
   Ponto2=0;//,Ponto3=0;
   datetime dt2=0;
   datetime DTretracao=0;
   if(Tendencia==1)
     {
      if(iLow(m_symbol.Name(),tempoMaior,1)==L)
        {
         Ponto1=H;
         Ponto2=L;
         DTretracao=TPBOSell[2];
         dt2=TPBOBuy[2];
         D12=H-L;
        }
        PrecoAberturaSell0=0;
     }
   else
     {
      if(iHigh(m_symbol.Name(),tempoMaior,1)==H)
        {
         Ponto1=L;
         Ponto2=H;
         DTretracao=TPBOBuy[2];
         dt2=TPBOSell[2];
         D12=H-L;
        }
        PrecoAberturaBuy0=0;
     }
   if(Ponto1+Ponto2!=0)
     {
      Preco50=(Ponto1+Ponto2)/2;
      MqlDateTime mdtR;
      TimeToStruct(DTretracao,mdtR);
      string Retr="Retracao"+IntegerToString(mdtR.year*100000000+mdtR.mon*1000000+mdtR.day*10000+mdtR.hour*100+mdtR.min);

      if(LoteComprado+LoteVendido==0)
         fPasso8(O,H,L,C,ATRpbo);

      if(ObjectFind(Chart,Retr)<0)
        {
         ObjectCreate(Chart,Retr,OBJ_FIBO,0,DTretracao,Ponto1,dt2,Ponto2);
         if(Cancelou5)
           {
            Cancelou5=false;
            ValorPasso5="-";
           }
         ChartRedraw(0);
        }
     }


  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void fPasso8(double O,double H,double L,double C,double ATRpbo)
  {
   if(ATRpbo==0)
     {
      PrecoAberturaBuy0=0;
      PrecoAberturaSell0=0;
      return;
     }
   /*
   fPasso8();
          passo 8
          na compra se (fechamento - abertura do candle pbo1) menor que 1x ATR executa entrada 1 tic acima da Mínima (ponto2 = nivel 0 da retração) do candle que confirma pbo1
          ou executa entrada 1 tic acima da abertura do candle confirmação do pbo1.
          }

          Alterado no txt4 do Galvão
   */

   /*
   ""COLOCAR JANELA DE PARAMETRO DE ESTOPE ex:   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   Janela 1 Qtd mínima de pontos (Então não abre se a distância de stop for menor que este valor. É isso?) SIM ABRE MANTENDO A QTD MÍNIMA DE CTOS.
   x Janela 2 Qtd de Lotes para a Qtd Mínima de pontos (Lote para a quantidade mínima de pontos = Lote máximo?)SIM É O LOTE MÁXIMO PERMITIDO
   x Janela 3 Ajuste em contratos por oscilação. (Então se o estope calculado no Passo 4 for 40 pontos e na Janela 1=40pts, Janela 2=20cts, janela 3=3ctos de ajuste.
   JANELA 4 a Cada 10 pontos a mais que 40 pontos reduz 3 contratos dos 20 mínimo e assim quanto maior o Range do estope Calculado no Passo4 menor será a qtd
   de lotes ajustada para executar a entrada.
   XJANELA 4 QTD OSCILAÇÃO EM TICS

   *ACRESCENTEI A JANELA 4

   *Se a distância for 40, abre com lote de 20. Se for 50, abre com lote de 17. Se for 60, abre com lote de 14. É isso? *SIM EXATAMENTE. ACRESCENTEI A JANELA ASSIM FICA AJUSTAVEL. A IDEIA É AJUSTAR UM VALOR DE PERDA MÁXIMA.
   */


   if(Trend1==1)
     {
      if(C-O<ATRpbo)
         PrecoAberturaBuy0=L;
      else
         PrecoAberturaBuy0=O;
      PrecoAberturaSell0=0;
      //StopInicial = L-D12;
      StopInicial0buy = PrecoAberturaBuy0-(D12*1.618);
      //Preco1618 = L+(D12*1.618);
      Preco100=L+(D12*iMult2);//Para Parcial2
      Precon1=L-D12;//Para entrada2

      double DStop=PrecoAberturaBuy0-StopInicial0buy;
      if(DStop<=iJanela1*_Point)
        {
         dLote0=iJanela2;
         CalculoVolume(dLote0);
        }
      else
        {
         double AjusteLote=DStop-iJanela1*_Point;
         AjusteLote= (AjusteLote/(iJanela4*_Point))*iJanela3;
         dLote0=iJanela2-AjusteLote;
         CalculoVolume(dLote0);
        }
     }
   if(Trend1==-1)
     {
      if(O-C<ATRpbo)
         PrecoAberturaSell0=H;
      else
         PrecoAberturaSell0=O;
      PrecoAberturaBuy0=0;
      //StopInicial=H+D12;
      StopInicial0sell=H+(D12*1.618);
      //Preco1618 = H-(D12*1.618);
      Preco100 = H-D12; // Para Parcial2
      Precon1=H+D12;//Para entrada2;
      double DStop=StopInicial0sell-PrecoAberturaSell0;
      if(DStop<=iJanela1*_Point)
        {
         dLote0=iJanela2;
         CalculoVolume(dLote0);
        }
      else
        {
         double AjusteLote=DStop-iJanela1*_Point;
         AjusteLote= (AjusteLote/(iJanela4*_Point))*iJanela3;
         dLote0=iJanela2-AjusteLote;
         CalculoVolume(dLote0);
        }
     }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RodaPBO(int ini,datetime prev_time1,double &Open,double &High,double &Low,double &Close,double &ATRpbo)//,bool &Cancela)
  {

   bool CancelaOperacao=false;

   if(limite1<0)
      limite1=0;
   if(limite1>lim1)
      limite1=lim1;
   double ugSell=0,ugBuy=0;


   PBO(ini,tempografico,dtBuy1,dtSell1,limite1+2,Trend1,aTrend1,ugBuy,ugSell);

   if(Trend1==1 && ugBuy!=0 && ugBuy!=EMPTY_VALUE)
      UltimoGatilhoCompraConfirmado=ugBuy;
   if(Trend1==-1 && ugSell!=0 && ugSell!=EMPTY_VALUE)
      UltimoGatilhoVendaConfirmado=ugSell;

//Passo4 passo 4
//na venda se abertura do candle gatilho do pbo 1 menor ou igual abertura do candle gatilho do pbo 2  ou na compra abertura do candle gatilho do pbo 1 maior = ou igual abertura do candle gatilho do pbo 2 Cancela Operação, Ou,na venda se abertura do candle de confirmação pbo 1 menor ou igual abertura do candle de confirmação do pbo 2  ou na compra abertura do candle de confirmação pbo 1 maior ou igual abertura do candle de confirmação do pbo 2 Cancela Operação
// Se Venda: Se GatilhoPBO1<=GatilhoPBO2 = Cancela Operacao
// Se compra: Se GatilhoPBO1>=FatilhoPBO2 = Cancela Operacao
   /*
   GatilhoPBO2Compra Atingido:
   * OpenGatilhoPBO1Compra<=OpenGatilhoPBO2Venda ===== Cancela Venda
   ou
   * OpenConfirmacaoPBO1Compra<=OpenConfirmacaoPBO2Venda ===== Cancela Venda

   GatilhoPBO2Venda Atingido:
   * OpenGatilhoPBO1Venda>=OpenGatilhoPBO2Compra ===== Cancela Compra
   ou
   * OpenConfirmacaoPBO1Venda>=OpenConfirmacaoPBO2Compra ===== Cancela Compra
   */
   if(TPBOBuy[2]>TPBOSell[2])
     {
      Trend1=1;
      fim=dtBuy1;
      if(TPBOBuy[1]>TPBOSell[2])
        {
         aTrend1=1;
         ValorPasso7="Cancelado";
         Cancelou7=true;

         /* int sBuy=Bars(Symbol(),tempografico,TPBOBuy[1],iTime(Symbol(),tempografico,0));
          High=iHigh(Symbol(),tempografico,sBuy);
          Low=iLow(Symbol(),tempografico,sBuy);*/
        }
      if(TPBOBuy[1]<TPBOSell[2])
        {
         aTrend1=-1;
         ValorPasso7="-";
         Cancelou7=false;
         int sSell=Bars(Symbol(),tempografico,TPBOSell[2],iTime(Symbol(),tempografico,1));//Barra do PBO2
         //Print("sSell=",sSell);
         int sBuy=Bars(Symbol(),tempografico,TPBOBuy[2],iTime(Symbol(),tempografico,1));//Barra do PBO1
         //Print("SBuy=",sBuy);
         if(sBuy==1)
           {
            Cancelou6=false;
            ValorPasso6="-";
           }
         High=iHigh(Symbol(),tempografico,sSell);
         Low=iLow(Symbol(),tempografico,sSell);
         Open=iOpen(Symbol(),tempografico,sSell);
         Close=iClose(Symbol(),tempografico,sSell);
         HighPBO1 = High;
         LowPBO1= Low;
         double ATR1[1];
         CopyBuffer(atr_handle,0,sSell,1,ATR1);
         ATRpbo=ATR1[0];
         // Se compra: Se GatilhoPBO1>=FatilhoPBO2 = Cancela Operacao
         if(iPasso4)
           {
            if(UltimoGatilhoVendaConfirmado>=UltimoGatilhoCompraConfirmado)
               CancelaOperacao=true;
            sBuy=Bars(Symbol(),tempografico,TPBOBuy[2],iTime(Symbol(),tempografico,1));
            double OpenBuy=iOpen(Symbol(),tempografico,sBuy);
            double OpenSell=iOpen(Symbol(),tempografico,sSell);
            if(OpenSell>=OpenBuy)
               CancelaOperacao=true;
            /*
            GatilhoPBO2Compra Atingido:
            * OpenGatilhoPBO1Compra<=OpenGatilhoPBO2Venda ===== Cancela Venda
            ou
            * OpenConfirmacaoPBO1Compra<=OpenConfirmacaoPBO2Venda ===== Cancela Venda
            */
           }


        }
     }
   if(TPBOSell[2]>TPBOBuy[2])
     {
      Trend1=-1;
      fim=dtSell1;
      if(TPBOSell[1]>TPBOBuy[2])
        {
         aTrend1=-1;
         ValorPasso7="Cancelado";
         Cancelou7=true;
         /* int sBuy=Bars(Symbol(),tempografico,TPBOSell[1],iTime(Symbol(),tempografico,0));
         High=iHigh(Symbol(),tempografico,sBuy);
         Low=iLow(Symbol(),tempografico,sBuy);*/
        }
      if(TPBOSell[1]<TPBOBuy[2])
        {
         aTrend1=1;
         ValorPasso7="-";
         Cancelou7=false;
         //******************
         int sSell=Bars(Symbol(),tempografico,TPBOSell[2],iTime(Symbol(),tempografico,1));//PBO1

         //Print("sSell=",sSell);
         int sBuy=Bars(Symbol(),tempografico,TPBOBuy[2],iTime(Symbol(),tempografico,1));//PBO2
         if(sSell==1)
           {
            Cancelou6=false;
            ValorPasso6="-";
           }
         High=iHigh(Symbol(),tempografico,sBuy);//Máxima do PBO1
         Low=iLow(Symbol(),tempografico,sBuy);
         Open=iOpen(Symbol(),tempografico,sBuy);
         Close=iClose(Symbol(),tempografico,sBuy);
         HighPBO1 = High;
         LowPBO1= Low;
         double ATR1[1];
         CopyBuffer(atr_handle,0,sBuy,1,ATR1);
         ATRpbo=ATR1[0];
         // Se Venda: Se GatilhoPBO1<=GatilhoPBO2 = Cancela Operacao
         if(iPasso4)
           {
            if(UltimoGatilhoCompraConfirmado<=UltimoGatilhoVendaConfirmado)
               CancelaOperacao=true;
            sSell=Bars(Symbol(),tempografico,TPBOSell[2],iTime(Symbol(),tempografico,1));
            double OpenBuy=iOpen(Symbol(),tempografico,sBuy);
            double OpenSell=iOpen(Symbol(),tempografico,sSell);
            if(OpenSell>=OpenBuy)
               CancelaOperacao=true;
            /*
            GatilhoPBO2Venda Atingido:
            * OpenGatilhoPBO1Venda>=OpenGatilhoPBO2Compra ===== Cancela Compra
            ou
            * OpenConfirmacaoPBO1Venda>=OpenConfirmacaoPBO2Compra ===== Cancela Compra
            */
           }

        }
     }

   /*
      Print("ugSell=",UltimoGatilhoVendaConfirmado,", ugBuy=",UltimoGatilhoCompraConfirmado);
      Print("Buy");
      ArrayPrint(TPBOBuy);
      Print("Sell");
      ArrayPrint(TPBOSell);
      */
   /*
   passo 5
   na compra se preço negociar 1tic acima do pbo1 e negociar 1x ATR a favor da operação ou negociar 1 tic acima do pbo1 e negociar 1 tic da Máxima do candle anterior
   ou negociar 1 tic acima do pbo1 e negociar 1 tic abaixo de 50% da retração Cancela a Operação
   */

   /*
      fim=dtSell1;
      if(dtBuy1>dtSell1)
         fim=dtBuy1;
   */
//if(Trend1!=0)         gdt2=fim;


//Print("prev=",prev_time1,", fim=",fim);
   limite1=Bars(m_symbol.Name(),tempografico,prev_time1,fim);
   if(limite1>lim1)
      limite1=lim1;



   if(CancelaOperacao)
      ValorPasso4="Cancelado";
   else
      ValorPasso4="-";

   AtualizaTela();

   return CancelaOperacao;
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
/*
void OnTimer()
  {
//---

  }*/
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
  {
//---
   if(!inicio)// || ModoCadastro)
      return;
//OnTrade:
//double LucroDia=0,LucroTotal=0;
   AjustaHist();     // OperacoesMkt
//AjustaPainel();
  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
/*double OnTester()
  {
//---
   double ret=AccountInfoDouble(ACCOUNT_PROFIT;
   FechaTudo();
//---
   ObjectsDeleteAll();
//---
   return(ret);
  }*/
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---


// Prossegue=false;
// Fechatudo;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void PBO(int ini,ENUM_TIMEFRAMES tempo,datetime &TempoBuy,datetime &TempoSell,int limite,int Tendencia,int aTendencia,double &ugBuy,double &ugSell)//,int TrendFilter)
  {

   if(limite<2)
      return;


   double Open[],High[],Low[],Close[],sma[];
   datetime Time[];
   ArrayResize(Open,limite);
   ArrayResize(High,limite);
   ArrayResize(Low,limite);
   ArrayResize(Close,limite);
   ArrayResize(Time,limite);
   ArrayResize(sma,limite);

   CopyOpen(Symbol(),tempo,ini,limite,Open);
   CopyHigh(Symbol(),tempo,ini,limite,High);
   CopyLow(Symbol(),tempo,ini,limite,Low);
   CopyClose(Symbol(),tempo,ini,limite,Close);
   CopyTime(Symbol(),tempo,ini,limite,Time);


   CopyBuffer(sma_handle,0,ini,limite,sma);


   int limitePBO=limite;
   double fUltimoGatilhoCompraConfirmado=0,fUltimoGatilhoVendaConfirmado=0;
   double GatilhoBuy[Gaps],GatilhoSell[Gaps];//Valor do gatilho
   datetime TempoGatilhoBuy[Gaps],TempoGatilhoSell[Gaps];
   int gb=0,gs=0;//gatilho da vez

   for(int g=0; g<Gaps; g++)
     {
      GatilhoSell[g]=0;
      GatilhoBuy[g]=0;
     }

   for(int i=0; i<limitePBO; i++)
     {
      for(int j=0; j<Gaps; j++)
        {
         if(TempoGatilhoBuy[j]>0 && GatilhoBuy[j]>0 && GatilhoBuy[j]!=EMPTY_VALUE)
           {
            if(sma[i]>=GatilhoBuy[j] && (GatilhoBuy[j]>0 && GatilhoBuy[j]!=EMPTY_VALUE) && Time[i]>=TempoGatilhoBuy[j])// && aTendencia!=Tendencia)
              {
               Tendencia=1;
               TempoBuy=Time[i];
               if((fUltimoGatilhoCompraConfirmado<=GatilhoBuy[j] || fUltimoGatilhoCompraConfirmado==0) && GatilhoBuy[j]!=0 && GatilhoBuy[j]!=EMPTY_VALUE)
                 {
                  fUltimoGatilhoCompraConfirmado=GatilhoBuy[j];
                  bool AtribuiTempo=true;
                  for(int h=0; h<3; h++)
                    {
                     if(TPBOBuy[h]==TempoBuy)
                        AtribuiTempo=false;
                    }
                  if(AtribuiTempo)
                    {
                     TPBOBuy[0]=TempoBuy;
                     ArraySort(TPBOBuy);
                    }
                 }
               for(int g=0; g<Gaps; g++)
                 {
                  GatilhoSell[g]=0;
                 }
               if(Operou1 && LoteComprado+LoteVendido==0)
                 {
                  Operou1=false;
                  Operou2=false;
                  Cancelou5=false;
                  ValorPasso5="-";

                 }
               if(iPBO)
                  DesenhaLn(Tendencia,TempoBuy);
               /*  if(iGatilhos)
                   {
                    if(aTendencia!=Tendencia)
                      {
                       //Print("Confirmado2:Gatilho compra = ",GatilhoBuy[j],", TempoGat=",TempoGatilhoBuy[j]);
                       //Print("sma=",sma[i],", tempo smaBuy=",Time[i]);
                      }
                    else{
                       //Print("Confirmado2 compra tempo",", mantém. ",TempoGatilhoBuy[j]);
                       }
                   }*/
               GatilhoBuy[j]=0;
              }
           }
         if(TempoGatilhoSell[j]>0 && GatilhoSell[j]>0 && GatilhoSell[j]!=EMPTY_VALUE)// && UltimoTempoSell<=Time[i] && (GatilhoSell[j]<fUltimoGatilhoVendaConfirmado || fUltimoGatilhoVendaConfirmado==0))// && (TrendFilter!=1))
           {
            if(sma[i]<=GatilhoSell[j] && (GatilhoSell[j]>0 && GatilhoSell[j]!=EMPTY_VALUE) && Time[i]>=TempoGatilhoSell[j])// && aTendencia!=Tendencia
              {
               Tendencia=-1;
               TempoSell=Time[i];
               if((fUltimoGatilhoVendaConfirmado>=GatilhoSell[j]  || fUltimoGatilhoVendaConfirmado==0) && GatilhoSell[j]!=0 && GatilhoSell[j]!=EMPTY_VALUE)
                 {
                  fUltimoGatilhoVendaConfirmado=GatilhoSell[j];
                  bool AtribuiTempo=true;
                  for(int h=0; h<3; h++)
                    {
                     if(TPBOSell[h]==TempoSell)
                        AtribuiTempo=false;
                    }
                  if(AtribuiTempo)
                    {
                     TPBOSell[0]=TempoSell;
                     ArraySort(TPBOSell);
                    }
                 }
               for(int g=0; g<Gaps; g++)
                 {
                  GatilhoBuy[g]=0;
                 }
               if(Operou1 && LoteComprado+LoteVendido==0)
                 {
                  Operou1=false;
                  Operou2=false;
                  Cancelou5=false;
                  ValorPasso5="-";
                 }
               if(iPBO)
                  DesenhaLn(Tendencia,TempoSell);
               /*if(iGatilhos)
                 {
                  if(aTendencia!=Tendencia)
                    {
                     Print("Confirmado2:Gatilho Venda = ",GatilhoSell[j],", TempoGat=",TempoGatilhoSell[j]);
                     Print("sma=",sma[i],", tempo smaSell=",Time[i]);
                    }
                  else
                     Print("Confirmado venda tempo",", mantém. ",TempoGatilhoSell[j]);
                 }*/
               GatilhoSell[j]=0;
              }
           }
        }
      //(1)
      //Colocação de Gatilhos
      if(i<limitePBO-2)
        {
         //Print("limite=",limite,", i=",i,", Open=",Open[i],", Time=",Time[i]);
         //um sobe, acima da média, 2 desce, 3 abre acima da média e fecha acima da abertura do 2
         //if(TrendFilter!=-1)
         if(Open[i]<Close[i] && Close[i]>sma[i] && Open[i+1]>sma[i+1] && Open[i+1]>=Close[i+1] && Open[i+2]>sma[i+2] && Close[i+2]>=Open[i+1])// && (GatilhoBuy<Open[i+2] || GatilhoBuy==0))
           {
            if(GatilhoBuy[gb]!=Open[i+2] && Open[i+2]>GatilhoBuy[gb])
              {

               GatilhoBuy[gb]=Open[i+2];
               TempoGatilhoBuy[gb]=Time[i+2];
               if(MostraGatilhos)
                  Print("Gat Colocado2:Gatilho compra = ",GatilhoBuy[gb],", TempoGat=",TempoGatilhoBuy[gb],", sma=",sma[i],", tempo sma=",Time[i]);
               gb++;
               if(gb>=Gaps)
                  gb=0;
              }
           }
         if(Open[i]>Close[i] && Close[i]<sma[i] && Open[i+1]<sma[i+1] && Open[i+1]<=Close[i+1] && Open[i+2]<sma[i+2] && Close[i+2]<=Open[i+1])// && (GatilhoSell>Open[i+2] || GatilhoSell==0))
           {
            if(GatilhoSell[gs]!=Open[i+2] && Open[i+2]<GatilhoSell[gs])
              {
               GatilhoSell[gs]=Open[i+2];
               TempoGatilhoSell[gs]=Time[i+2];
               if(MostraGatilhos)
                  Print("Gat Colocado2: Gatilho Venda = ",GatilhoSell[gs],", TempoGat=",TempoGatilhoSell[gs],",sma=",sma[i],", tempo sma=",Time[i]);
               gs++;
               if(gs>=Gaps)
                  gs=0;
              }
           }
        }
      if(i<limitePBO-1)
        {
         if(Open[i+1]>sma[i+1] && High[i+0]>sma[i+0] && ((Open[i+1]>High[i+0])||(Close[i+1]>=High[i+0])) && Close[i+1]>=Open[i+1])// && (GatilhoBuy<Open[i+1] || GatilhoBuy==0))
           {
            if(GatilhoBuy[gb]!=Open[i+1])
              {

               GatilhoBuy[gb]=Open[i+1];
               TempoGatilhoBuy[gb]=Time[i+1];
               if(MostraGatilhos)
                  Print("Gat Colocado1:Gatilho compra = ",GatilhoBuy[gb],", TempoGat=",TempoGatilhoBuy[gb],", sma=",sma[i],", tempo sma=",Time[i]);
               gb++;
               if(gb>=Gaps)
                  gb=0;
              }
           }
         if(Open[i+1]<sma[i+1] && Low[i+0]<sma[i+0] && ((Open[i+1]<Low[i+0])||(Close[i+1]<=Low[i+0])) && Close[i+1]<=Open[i+1])// && (GatilhoSell>Open[i+1] || GatilhoSell==0))
           {
            if(GatilhoSell[gs]!=Open[i+1])
              {
               GatilhoSell[gs]=Open[i+1];
               TempoGatilhoSell[gs]=Time[i+1];
               if(MostraGatilhos)
                  Print("Gat Colocado1:Gatilho Venda = ",GatilhoSell[gs],", TempoGat=",TempoGatilhoSell[gs],",sma=",sma[i],", tempo sma=",Time[i]);
               gs++;
               if(gs>=Gaps)
                  gs=0;
              }
           }
        }


     }

   ugBuy=fUltimoGatilhoCompraConfirmado;
   ugSell=fUltimoGatilhoVendaConfirmado;

   TempoBuy=TPBOBuy[2];
   TempoSell=TPBOSell[2];
   /*UltimoTempoBuy - criar um arrays dos últimos tempos, conferidos fora do
      PBO()
      UltimoTempoSell - idem
      */

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DesenhaLn(int Trend,datetime Data)
  {
   MqlDateTime mqln;
   TimeToStruct(Data,mqln);
   long nLn=mqln.year*100000000+mqln.mon*1000000+mqln.day*10000+mqln.hour*100+mqln.min;

   if(Trend==1)
     {
      LnB1=nLn;
      if(ObjectFind(Chart1,"PBOCompra1_"+IntegerToString(LnB1))>=0)
         return;
      ObjectCreate(Chart1,"PBOCompra1_"+IntegerToString(LnB1),OBJ_VLINE,0,Data,ASK);
      ObjectSetInteger(Chart1,"PBOCompra1_"+IntegerToString(LnB1),OBJPROP_COLOR,clr_buyTrend);
      ObjectSetInteger(Chart1,"PBOCompra1_"+IntegerToString(LnB1),OBJPROP_STYLE,STYLE_DASHDOT);


     }

   if(Trend==-1)
     {
      LnS1=nLn;
      if(ObjectFind(Chart1,"PBOVenda1_"+IntegerToString(LnS1))>=0)
         return;
      ObjectCreate(Chart1,"PBOVenda1_"+IntegerToString(LnS1),OBJ_VLINE,0,Data,BID);
      ObjectSetInteger(Chart1,"PBOVenda1_"+IntegerToString(LnS1),OBJPROP_COLOR,clr_sellTrend);
      ObjectSetInteger(Chart1,"PBOVenda1_"+IntegerToString(LnS1),OBJPROP_STYLE,STYLE_DASHDOT);


     }
//aaTrend1=Trend1;
   ChartRedraw(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Indicadores()
  {

//int Chart1,Chart2,Chart3;


//   else      Chart1=ChartOpen(m_symbol.Name(),tempografico);

   sma_handle = iMA(Symbol(),tempografico,smaPeriod,smaShift,smaMode,smaPrice);
   if(Period()==tempografico || tempografico==PERIOD_CURRENT)
      ChartIndicatorAdd(Chart1,0,sma_handle);

   atr_handle=iATR(Symbol(),tempografico,atrPeriod);
   if(Period()==tempografico || tempografico==PERIOD_CURRENT)
      ChartIndicatorAdd(Chart1,1,atr_handle);

   if(utilGator)
     {
      gator_handle=iGator(Symbol(),tempografico,InpJawsPeriod,InpJawsShift,InpTeethPeriod,InpTeethShift,InpLipsPeriod,InpLipsShift,InpMAMethod,InpAppliedPrice);
      if(Period()==tempografico || tempografico==PERIOD_CURRENT)
         ChartIndicatorAdd(Chart1,2,gator_handle);
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CalculaHorario()
  {
   Iniciar=iIniHr*100+iIniMn;
//Iniciar=0;
   Finalizar=iFnlHr*100+iFnlMn;
//Finalizar=0;
   Derrubar=Finalizar+iDerr;
//Derrubar=0;
//funciona=false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Agora()
  {
   TimeCurrent(mdt2);
   switch(LocalTime)
     {
      case HoraLocal:
         dAgora=TimeLocal(mdt1);
         break;
      case HoraCorrente:
         dAgora=TimeCurrent(mdt1);
         break;
      default: // gmt
         dAgora=TimeGMT(mdt1);
         break;
     }

   lAgora   = mdt1.hour*100+mdt1.min;
   Hoje     = mdt1.year*10000+mdt1.mon*100+mdt1.day;
   dHoje    = StringSubstr((string)dAgora,0,10);
   dHojeBroker=StringSubstr((string)TimeCurrent(mdt1),0,10);

   bool VerifFuncionamento=Funcionamento();

   if(!funciona && VerifFuncionamento)
      funciona = true;
   if(funciona && !VerifFuncionamento)
      funciona = false;

//Print("Funciona=",funciona);
   if(Ontem!=Hoje)
     {
      Ontem=Hoje;
      Prossegue=true;
      Recado="Virou o dia!";
      if(PrintRecado)
         Print(Recado);
      //ViraDia();//Tem que ter no robô principal

     }


  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Funcionamento()
  {
   if(Iniciar==Finalizar)
      return true;



   if(Iniciar<Finalizar)
     {
      if(lAgora>Iniciar && lAgora<Finalizar)
         return true;
      else //if(lAgora>Iniciar && lAgora>Finalizar)
        {
         if(lAgora>Derrubar && LoteComprado+LoteVendido>0 && Derrubar!=0)
            FechaTudo();
         return false;
        }
     }
   else
     {
      if(lAgora>Iniciar || lAgora<Finalizar)
         return true;
      else
        {
         if(lAgora>Derrubar && LoteComprado+LoteVendido>0 && Derrubar!=0)
            FechaTudo();
         return false;
        }
     }


   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void InicializaValores()
  {

   DadosAtivo();
   PreparaFundoTela(0);
   limite1=lim1;
   LnB1=0;
   LnS1=0;
   iExp=0;
   for(int i=0; i<3; i++)
     {
      TPBOBuy[i]=0;
      TPBOSell[i]=0;
     }

   Cancelou5=false;
   ValorPasso5="-";
   Cancelou4=false;
   ValorPasso4="-";
   PrecoAberturaBuy0=0;
   PrecoAberturaSell0=0;

   Operou1=false;
   Operou2=false;
   AjustaHist();
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool RefreshRates()
  {
//if(VerificaOp)      Print(__FUNCTION__);
//--- refresh rates
   if(!m_symbol.RefreshRates())
      return(false);
//--- protection against the return value of "zero"
   ASK=SymbolInfoDouble(m_symbol.Name(),SYMBOL_ASK);
   BID=SymbolInfoDouble(m_symbol.Name(),SYMBOL_BID);
   if(ASK == 0 || BID == 0)
      return(false);

   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool trade_session()
  {
   ENUM_DAY_OF_WEEK day_of_week=SUNDAY;
   datetime time_now = TimeCurrent();
   MqlDateTime time;
   TimeToStruct(time_now, time);
   uint week_day_now = time.day_of_week;
   uint seconds_now = (time.hour * 3600) + (time.min * 60) + time.sec;
   if(week_day_now == 0)
      day_of_week = SUNDAY;
   if(week_day_now == 1)
      day_of_week = MONDAY;
   if(week_day_now == 2)
      day_of_week = TUESDAY;
   if(week_day_now == 3)
      day_of_week = WEDNESDAY;
   if(week_day_now == 4)
      day_of_week = THURSDAY;
   if(week_day_now == 5)
      day_of_week = FRIDAY;
   if(week_day_now == 6)
      day_of_week = SATURDAY;
   datetime from, to;
   uint session = 0;
   while(SymbolInfoSessionTrade(_Symbol, day_of_week, session, from, to))
     {
      session++;
     }
   uint trade_session_open_seconds = uint(from);
   uint trade_session_close_seconds = uint(to);
   if(trade_session_open_seconds < seconds_now && trade_session_close_seconds > seconds_now && week_day_now >= 1 && week_day_now <= 5)
      return(true);
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DadosAtivo()
  {
//if(iMAGIC==0)
   nMAGIC=iMAGIC;
   nMAGIC2=iMAGIC2;
   if(nMAGIC<1)
     {
      MessageBox("O número mágico deve ser maior que zero");
      ExpertRemove();
     }
   if(nMAGIC2<1 || nMAGIC2==nMAGIC)
     {
      MessageBox("O númego mágico da segunda entrada deve ser diferente do principal");
      ExpertRemove();
     }

   m_symbol.Name(Symbol());
   m_trade1.SetExpertMagicNumber(nMAGIC);            // sets magic number
   m_trade2.SetExpertMagicNumber(nMAGIC2);
   m_trade1.SetTypeFilling(ORDER_FILLING_RETURN);   //Para corretora Modal
   m_trade2.SetTypeFilling(ORDER_FILLING_RETURN);


   PassoVolume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_STEP);
   if(!RefreshRates())
     {
      Sleep(300);
      RefreshRates();
     }

   double minLote=SymbolInfoDouble(m_symbol.Name(),SYMBOL_VOLUME_MIN);
   double divLote=SymbolInfoDouble(m_symbol.Name(),SYMBOL_VOLUME_STEP);
   VolumeMinimo = minLote;
//dLote é calculado baseado na fórmula estipulada
   /*if(iLote>0)
     {
      dLote=iLote;
      CalculoVolume(dLote);
     }
   else
     {
      //dLote=iVolumeFin/ASK;
      dLote=minLote;
      CalculoVolume(dLote);
     }*/
   if(iLote2>0)
     {
      dLote2=iLote2;
      CalculoVolume(dLote2);
     }
   else
     {
      //dLote=iVolumeFin/ASK;
      dLote2=0.00;//minLote;
     }
   /*
      dLoteP1=MathCeil(iLoteP1/PassoVolume)*PassoVolume;
      if(dLoteP1>=dLote1)
        {
         dLoteP1=MathFloor(iLoteP1/PassoVolume)*PassoVolume;
         if(dLoteP1>=dLote1)
            dLoteP1=0;
        }

      dLoteP2=MathCeil(iLoteP2/PassoVolume)*PassoVolume;
      if(dLoteP2>=dLote1)
        {
         dLoteP2=MathFloor(iLoteP2/PassoVolume)*PassoVolume;
         if(dLoteP2>=dLote1)
            dLoteP2=0;
        }

      dLoteP3=MathCeil(iLoteP3/PassoVolume)*PassoVolume;
      if(dLoteP3>=dLote1)
        {
         dLoteP3=MathFloor(iLoteP3/PassoVolume)*PassoVolume;
         if(dLoteP3>=dLote1)
            dLoteP3=0;
        }*/

   divSymbol   = SymbolInfoDouble(Symbol(),SYMBOL_TRADE_TICK_SIZE);
   Espaco      = MathCeil((SymbolInfoInteger(Symbol(),SYMBOL_TRADE_FREEZE_LEVEL)+SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL))*_Point/divSymbol)*divSymbol + 2*divSymbol;

   fator9 = ifator9;
   nTicksAbertura = inTicksAbertura;


//OffSet=iOffSet*divSymbol;

//    BE = MathCeil(iBE*_Point/divSymbol)*divSymbol;
//    SL_Fixo=MathCeil(iSL*_Point/divSymbol)*divSymbol;
//    TP_Fixo=MathCeil(iTP*_Point/divSymbol)*divSymbol;
//    TrailingFixo=MathCeil(iTrailingFixo*_Point/divSymbol)*divSymbol;
//    dParcial=MathCeil(iParcial*_Point/divSymbol)*divSymbol;

//if(iBE==0 && SL_Fixo>0)      BE=SL_Fixo;
// * * * * * * * * * * * * * * * * * * *

   if(PassoVolume>=1)
      dVol=0;
   if(PassoVolume<1 && PassoVolume>=0.1)
      dVol=1;
   if(PassoVolume<0.1 && PassoVolume>=0.01)
      dVol=2;
   if(PassoVolume<0.01 && PassoVolume>=0.001)
      dVol=3;
   if(PassoVolume<0.001 && PassoVolume>=0.0001)
      dVol=4;
   if(PassoVolume<0.0001 && PassoVolume>=0.00001)
      dVol=5;
   if(PassoVolume<0.00001 && PassoVolume>=0.000001)
      dVol=6;
   if(PassoVolume<0.000001 && PassoVolume>=0.0000001)
      dVol=7;
   if(PassoVolume<0.0000001)
      dVol=8;

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void PreparaFundoTela(long Chart=0,int Tipo=1)
  {
   FONTE = AjustaFONTE();

   if(Tipo != 1)
     {

      ChartSetInteger(Chart, CHART_SHOW_GRID, false);
      ChartSetInteger(Chart, CHART_MODE, CHART_CANDLES);
      ChartSetInteger(Chart,CHART_SHOW_PERIOD_SEP,false);
      ChartSetInteger(Chart,CHART_COLOR_FOREGROUND,clr_foreground);
      ChartSetInteger(Chart,CHART_COLOR_BACKGROUND, clr_background);
      ChartSetInteger(Chart, CHART_COLOR_CANDLE_BULL, clr_background);
      ChartSetInteger(Chart, CHART_COLOR_CHART_UP, clr_background);//clrDodgerBlue);
      ChartSetInteger(Chart, CHART_COLOR_CANDLE_BEAR, clr_background);//clr_background);
      ChartSetInteger(Chart, CHART_COLOR_CHART_DOWN, clr_background);//clrSteelBlue);
      ChartSetInteger(Chart, CHART_COLOR_CHART_LINE, clr_background);//clrDodgerBlue);
      ChartSetInteger(Chart, CHART_COLOR_LAST, clr_background);//clrRed);
      ChartSetInteger(Chart, CHART_COLOR_BID, clr_background);//clrGray);
      ChartSetInteger(Chart, CHART_COLOR_ASK, clr_background);//clrGray);
     }
   else
     {

      // Seta as cores da barra de alta
      ChartSetInteger(Chart, CHART_COLOR_CANDLE_BULL, clr_Candle_Bull);//- C'10,10,10');
      ChartSetInteger(Chart, CHART_COLOR_CHART_UP, clr_Chart_Up);//- C'10,10,10');
      // Seta as cores da barra de baixa
      ChartSetInteger(Chart, CHART_COLOR_CANDLE_BEAR, clr_Candle_Bear);//- C'10,30,30');
      ChartSetInteger(Chart, CHART_COLOR_CHART_DOWN, clr_Chart_Dn);//- C'10,30,30');
      //Seta a cor da barra de indecisão
      ChartSetInteger(Chart, CHART_COLOR_CHART_LINE, clr_Chart_Line);//- C'30,30,30');

      ChartSetInteger(Chart, CHART_SHOW_GRID, false);
      ChartSetInteger(Chart,CHART_COLOR_FOREGROUND,clr_foreground);//Detalhes);
      //ChartSetInteger(0,CHART_COLOR_
      // Seta como gráfico de candles
      ChartSetInteger(Chart, CHART_MODE, CHART_CANDLES);
      ChartSetInteger(Chart,CHART_SHOW_PERIOD_SEP,ShowPeriodSep);

      ChartSetInteger(Chart, CHART_COLOR_BACKGROUND, clr_background);

      ChartSetInteger(Chart,CHART_SHOW_ASK_LINE,true);
      ChartSetInteger(Chart,CHART_SHOW_BID_LINE,true);
      ChartSetInteger(Chart, CHART_COLOR_BID, clrGray);
      ChartSetInteger(Chart, CHART_COLOR_ASK, clrRed);
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string AjustaFONTE()
  {
   switch(Fonte)
     {
      case Arial:
         return "Arial";
         break;
      case Calibri:
         return "Calibri";
         break;
      case LucidaConsole:
         return "Lucida Console";
         break;
      default:
         return "Calibri";
         break;
     }
   return "Arial";
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void FechaTudo()
  {
//if(VerificaOp)      Print(__FUNCTION__);
   bool Retorno=true;
   MqlTradeRequest request;
//if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))return ;
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong    position_ticket   = PositionGetTicket(i);                // bilhete da posição
      long     Pmagic            = PositionGetInteger(POSITION_MAGIC);  // MagicNumber da posição
      string   PAberta           = PositionGetSymbol(i);
      long     TipoOrdem         = PositionGetInteger(POSITION_TYPE);   // Tipo
      //double   Profit            = PositionGetDouble(POSITION_PROFIT);
      double   Volume            = PositionGetDouble(POSITION_VOLUME);
      if(Pmagic == nMAGIC && PAberta==m_symbol.Name())
        {
         if(TipoOrdem == POSITION_TYPE_BUY)
           {
            if(!m_trade1.PositionClose(position_ticket))
              {
               Print("Close buy order failed ("+PAberta+"). Start trailing stop...");
               DeveSairCompra=true;
               Recado="Fechamento não aconteceu.";
               if(PrintRecado)
                  Print(Recado);
               //Print(Recado);
               Retorno=false;
              }
           }
         if(TipoOrdem == POSITION_TYPE_SELL)
           {
            if(!m_trade1.PositionClose(position_ticket))
              {
               Print("Close sell order failed ("+PAberta+"). Start traling stop...");
               DeveSairVenda=true;
               Recado="Fechamento não aconteceu.";
               if(PrintRecado)
                  Print(Recado);
               //Print(Recado);
               Retorno=false;
              }
           }
        }
      if(Pmagic == nMAGIC2 && PAberta==m_symbol.Name())
        {
         if(TipoOrdem == POSITION_TYPE_BUY)
           {
            if(!m_trade2.PositionClose(position_ticket))
              {
               Print("Close buy order failed ("+PAberta+"). Start trailing stop...");
               DeveSairCompra=true;
               Recado="Fechamento não aconteceu.";
               if(PrintRecado)
                  Print(Recado);
               //Print(Recado);
               Retorno=false;
              }
           }
         if(TipoOrdem == POSITION_TYPE_SELL)
           {
            if(!m_trade2.PositionClose(position_ticket))
              {
               Print("Close sell order failed ("+PAberta+"). Start traling stop...");
               DeveSairVenda=true;
               Recado="Fechamento não aconteceu.";
               if(PrintRecado)
                  Print(Recado);
               //Print(Recado);
               Retorno=false;
              }
           }
        }
     }


   if(Retorno && (DeveSairCompra || DeveSairVenda))
     {
      DeveSairCompra=false;
      DeveSairVenda=false;
     }

   /* for(int i=OrdersTotal()-1; i>=0; i--)
      {
       ulong order_ticket=OrderGetTicket(i);
       long Pmagic=OrderGetInteger(ORDER_MAGIC);
       string PAberta=OrderGetString(ORDER_SYMBOL);
       if(Pmagic==nMAGIC && PAberta==m_symbol.Name())
         {
          if(!m_trade.OrderDelete(order_ticket))
            {
             //Recado="Ordem não cancelada.";
            }
         }

      }*/
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ArrastaSLgrudado(int Tipo)
  {
//if(VerificaOp)      Print(__FUNCTION__);
//if(Tipo==1)compra
//if(Tipo==-1)venda

//bool Retorno=true;
// if(VerificaFinal)      Print(__FUNCTION__);

   Espaco      = MathCeil((SymbolInfoInteger(Symbol(),SYMBOL_TRADE_FREEZE_LEVEL)+SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL))*_Point/divSymbol)*divSymbol + 2*divSymbol;

   double nPrecoSL=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong    position_ticket   = PositionGetTicket(i);                // bilhete da posição
      long     Pmagic            = PositionGetInteger(POSITION_MAGIC);  // MagicNumber da posição
      string   PAberta           = PositionGetSymbol(i);
      long     TipoOrdem         = PositionGetInteger(POSITION_TYPE);   // Tipo
      //double   Profit            = PositionGetDouble(POSITION_PROFIT);
      double preco = ASK;//PositionGetDouble(POSITION_PRICE_OPEN);
      double   Volume            = PositionGetDouble(POSITION_VOLUME);
      double SL=PositionGetDouble(POSITION_SL);
      double TP=PositionGetDouble(POSITION_TP);
      if(Pmagic == nMAGIC && PAberta==m_symbol.Name())
        {
         if(TipoOrdem == POSITION_TYPE_BUY && Tipo==1)
           {
            preco=BID;
            nPrecoSL=MathFloor((preco- -divSymbol)/divSymbol)*divSymbol;
            nPrecoSL=NormalizeDouble(nPrecoSL,m_symbol.Digits());
            //if(VerificaFinal)               Print("Novosl=",PrecoSL);
            if(nPrecoSL<BID-Espaco && (nPrecoSL>=SL+Espaco || SL==0))
              {
               if(!m_trade1.PositionModify(position_ticket,nPrecoSL,TP))
                 {
                  Print("Trailing stop failed. Order: ",position_ticket);
                 }
              }
           }
         if(TipoOrdem == POSITION_TYPE_SELL && Tipo==-1)
           {
            nPrecoSL=MathCeil((ASK+Espaco+divSymbol)/divSymbol)*divSymbol;
            nPrecoSL=NormalizeDouble(nPrecoSL,m_symbol.Digits());
            //if(VerificaFinal)               Print("Novosl=",PrecoSL);
            if(nPrecoSL>ASK+Espaco && (nPrecoSL<SL-Espaco || SL==0))
              {
               if(!m_trade1.PositionModify(position_ticket,nPrecoSL,TP))
                 {
                  Print("Trailing stop failed. Order: ",position_ticket);
                 }
              }
            //else {}
           }
        }
      if(Pmagic == nMAGIC2 && PAberta==m_symbol.Name())
        {
         if(TipoOrdem == POSITION_TYPE_BUY && Tipo==1)
           {
            preco=BID;
            nPrecoSL=MathFloor((preco- -divSymbol)/divSymbol)*divSymbol;
            nPrecoSL=NormalizeDouble(nPrecoSL,m_symbol.Digits());
            //if(VerificaFinal)               Print("Novosl=",PrecoSL);
            if(nPrecoSL<BID-Espaco && (nPrecoSL>=SL+Espaco || SL==0))
              {
               if(!m_trade2.PositionModify(position_ticket,nPrecoSL,TP))
                 {
                  Print("Trailing stop failed. Order: ",position_ticket);
                 }
              }
           }
         if(TipoOrdem == POSITION_TYPE_SELL && Tipo==-1)
           {
            nPrecoSL=MathCeil((ASK+Espaco+divSymbol)/divSymbol)*divSymbol;
            nPrecoSL=NormalizeDouble(nPrecoSL,m_symbol.Digits());
            //if(VerificaFinal)               Print("Novosl=",PrecoSL);
            if(nPrecoSL>ASK+Espaco && (nPrecoSL<SL-Espaco || SL==0))
              {
               if(!m_trade2.PositionModify(position_ticket,nPrecoSL,TP))
                 {
                  Print("Trailing stop failed. Order: ",position_ticket);
                 }
              }
            //else {}
           }
        }
     }

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CalculoVolume(double &LoteC)
  {
//VolumeFin

   LoteC=MathFloor(LoteC/PassoVolume)*PassoVolume;
   if(LoteC<SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN))
      LoteC=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN);

   if(LoteC>SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX))
      LoteC=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);

   /*double Margem=0;
   if(OrderCalcMargin(ORDER_TYPE_BUY,m_symbol.Name(),LoteC,ASK,Margem))
      TTMargem="Margem = "+DoubleToString(Margem,2);*/
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AjustaImediato()
  {
   LoteComprado=0;
   LoteVendido=0;
   LucroAbertas=0;
   VerificaPosicoes(LoteComprado,LoteVendido,LoteComprado2,LoteVendido2,LucroAbertas);    // OperacoesMkt
   p_Positions_Profit=DoubleToString(LucroAbertas,2);
   p_Buy_Lot=DoubleToString(LoteComprado+LoteComprado2,dVol);
   p_Sell_Lot=DoubleToString(LoteVendido+LoteVendido2,dVol);
//Recado          = Recado;
   if((Prossegue & funciona)>0)
     {
      p_Habilitado="true";
     }
   else
     {
      p_Habilitado="false";
      //Recado="Prossegue="+IntegerToString(Prossegue)+", funciona="+IntegerToString(funciona)+","+IntegerToString(p_Habilitado);
     }
//funciona=true;
//Print("Prossegue=",Prossegue,", funciona=",funciona," = ",Prossegue+funciona);

   AtualizaTela();
   ChartRedraw(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void VerificaPosicoes(double &fLoteComprado,double &fLoteVendido,double &fLoteComprado2,double &fLoteVendido2,double &fLucroAbertas)
  {
//if(VerificaOp)Print(__FUNCTION__);
   fLoteComprado=0;
   fLoteVendido=0;
   fLoteComprado2=0;
   fLoteVendido2=0;
   fLucroAbertas=0;
   double SLatual=0;
   PrecoEntrada=0;
   PrecoEntrada2=0;
   for(int i=PositionsTotal()-1; i>=0; i--)
     {
      ulong    position_ticket   = PositionGetTicket(i);                // bilhete da posição
      long     Pmagic            = PositionGetInteger(POSITION_MAGIC);  // MagicNumber da posição
      string   PAberta           = PositionGetSymbol(i);
      long     TipoOrdem         = PositionGetInteger(POSITION_TYPE);   // Tipo
      double   Profit            = PositionGetDouble(POSITION_PROFIT);
      double   Volume            = PositionGetDouble(POSITION_VOLUME);
      if(Pmagic == nMAGIC && PAberta==m_symbol.Name())
        {
         SLatual=PositionGetDouble(POSITION_SL);
         PrecoEntrada=PositionGetDouble(POSITION_PRICE_OPEN);
         fLucroAbertas+=Profit;
         BarraEntradaPrincipal = (datetime)PositionGetInteger(POSITION_TIME);
         if(TipoOrdem == POSITION_TYPE_BUY)
           {
            fLoteComprado+=Volume;
           }
         if(TipoOrdem == POSITION_TYPE_SELL)
           {
            fLoteVendido+=Volume;
           }
        }
      if(Pmagic == nMAGIC2 && PAberta==m_symbol.Name())
        {
         SLatual=PositionGetDouble(POSITION_SL);
         PrecoEntrada2=PositionGetDouble(POSITION_PRICE_OPEN);
         fLucroAbertas+=Profit;
         //BarraEntradaPrincipal = (datetime)PositionGetInteger(POSITION_TIME);
         if(TipoOrdem == POSITION_TYPE_BUY)
           {
            fLoteComprado2+=Volume;
           }
         if(TipoOrdem == POSITION_TYPE_SELL)
           {
            fLoteVendido2+=Volume;
           }
        }
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void LimpaIndicadores(long Chart=0)
  {

   long total_windows=ChartGetInteger(Chart,CHART_WINDOWS_TOTAL);
//Print("total_windows=",total_windows);
   string name;

   for(int j=0; j<ChartIndicatorsTotal(Chart,0); j++)
     {
      name=ChartIndicatorName(Chart,0,j);
      //if(!
      ChartIndicatorDelete(Chart,0,name);//)
      //Print("Não foi possível remover ",name);
     }

   while(total_windows>1)
     {
      for(int i=0; i<total_windows; i++)
        {
         for(int j=0; j<ChartIndicatorsTotal(Chart,i); j++)
           {
            name=ChartIndicatorName(Chart,i,j);
            ChartIndicatorDelete(Chart,i,name);//)
           }
        }
      total_windows=ChartGetInteger(Chart,CHART_WINDOWS_TOTAL);
     }

  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DesenhaPainel()
  {
//FONTE=AjustaFONTE();//tem no preparafundotela
   p_Comment       = iComentario;       // parâmetro do principal Strategy Name (parametro do EA)
   p_Positions_Profit   = "0.00";      // Lucro operações abertas (ok)
   p_Buy_Lot         = "0";         // Lote comprado (ok)
   p_Sell_Lot        = "0";         // Lote vendido (ok)
   p_Profit_Today    = "0.00";      // Lucro dia (ok)
   p_Profit        = "0.00";      // Lucro total (ok)
   p_Habilitado     = "false";
   Recado = "Ok";



   int nAcumulacao=10;

   int   Xsize =(int) MathCeil(120 * iFX),
         Ysize =(int) MathCeil((nTitulos+nAcumulacao) * iFX),
         sX    =(int) MathCeil(5 * iFX),
         sY    =(int) MathCeil(3 * iFX),
         X1    =(int) MathCeil(5 * iFX)+sX,
         Y1    =(int) MathCeil(5 * iFX)+(nTitulos)*(Ysize+sY)+Ysize*2+sY*2,
         Y2    =(int) MathCeil(5 * iFX)+(nTitulos+nAcumulacao)*(Ysize+sY)+Ysize*2+sY;
   string crTexto = Nome_EA+" "+p_Magic;
   string NomeCampo = "Nome_Expert";// + IntegerToString(i,d,'0') + IntegerToString(q);
   string ToolTip   = "Nome do Expert";
   int XX=X1;
   int YY=Y2;

   InsereCampo("FundoPainel","","",XX-sX,Xsize*2+sX*4,YY,(Ysize+sY+2)*(nTitulos+nAcumulacao),clr_pbackground,Font1);
   ObjectSetInteger(0,"FundoPainel", OBJPROP_BORDER_COLOR,clr_foreground);//COLOR_BTN);
//Print("crTexto=",crTexto);
   InsereCampo(NomeCampo,crTexto,ToolTip,XX-sX,Xsize*2+4*sX,Y2,Ysize,clr_foreground,clr_background);


   YY-=Ysize+2*sY;
   Y2=YY;
   crTexto = "Passo1";
   InsereCampo("tPasso1",crTexto,"",XX,Xsize,YY,Ysize,clr_pbackground,Font1);
   crTexto = "Passo2";
   YY-=Ysize+sY;
   InsereCampo("tPasso2",crTexto,"",XX,Xsize,YY,Ysize,clr_pbackground,Font1);

   crTexto = "Passo3";
   YY-=Ysize+sY;
   InsereCampo("tPasso3",crTexto,"",XX,Xsize,YY,Ysize,clr_pbackground,Font1);
   crTexto = "0.0;0.0";
//YY-=Ysize+sY;
   InsereCampo("vPasso3",crTexto,"",XX+Xsize+sX,Xsize,YY,Ysize,clr_pbackground,Font1);

   crTexto = "Passo4";
   YY-=Ysize+sY;
   InsereCampo("tPasso4",crTexto,"",XX,Xsize,YY,Ysize,clr_pbackground,Font1);
   crTexto="-";
   InsereCampo("vPasso4",crTexto,"",XX+Xsize+sX,Xsize,YY,Ysize,clr_pbackground,Font1);

   crTexto = "Passo5";
   YY-=Ysize+sY;
   InsereCampo("tPasso5",crTexto,"",XX,Xsize,YY,Ysize,clr_pbackground,Font1);
   crTexto="-";
   InsereCampo("vPasso5",crTexto,"",XX+Xsize+sX,Xsize,YY,Ysize,clr_pbackground,Font1);

   crTexto = "Passo6";
   YY-=Ysize+sY;
   InsereCampo("tPasso6",crTexto,"",XX,Xsize,YY,Ysize,clr_pbackground,Font1);
   crTexto="-";
   InsereCampo("vPasso6",crTexto,"",XX+Xsize+sX,Xsize,YY,Ysize,clr_pbackground,Font1);

   crTexto = "Passo7";
   YY-=Ysize+sY;
   InsereCampo("tPasso7",crTexto,"",XX,Xsize,YY,Ysize,clr_pbackground,Font1);
   crTexto="-";
   InsereCampo("vPasso7",crTexto,"",XX+Xsize+sX,Xsize,YY,Ysize,clr_pbackground,Font1);

   crTexto = "Passo8";
   YY-=Ysize+sY;
   InsereCampo("tPasso8",crTexto,"",XX,Xsize,YY,Ysize,clr_pbackground,Font1);
   crTexto="-";
   InsereCampo("vPasso8",crTexto,"",XX+Xsize+sX,Xsize,YY,Ysize,clr_pbackground,Font1);

   /*  crTexto = "TP Compra";
     YY-=Ysize+sY;
     InsereCampo("tTPbuy",crTexto,"",XX,Xsize,YY,Ysize,clr_pbackground,Font1);
     YY-=Ysize+sY;
     InsereCampo("dTPbuy",DoubleToString(TP_buy,_Digits),"",XX,Xsize,YY,Ysize,clr_edtbg,Font3);
     crTexto = "SL Compra";
     YY-=Ysize+sY;
     InsereCampo("tSLbuy",crTexto,"",XX,Xsize,YY,Ysize,clr_pbackground,Font1);
     YY-=Ysize+sY;
     InsereCampo("dSLbuy",DoubleToString(SL_buy,_Digits),"",XX,Xsize,YY,Ysize,clr_edtbg,Font3);
     YY-=Ysize+sY;
     InsereCampo("tVolFin",InfoVolFin,"",XX,Xsize,YY,Ysize,clr_pbackground,Font1);
     YY-=Ysize+sY;
     InsereCampo("tVolLote","Lote","Lote",XX,Xsize,YY,Ysize,clr_pbackground,Font1);
     YY-=Ysize+sY*3;
     InsereBotao("btnCompra","Buy","",XX,Xsize,YY,Ysize*2,clr_ButtonBuy,clr_BtFontBuy);

   */
   XX=X1;
   YY=Y1;
//p_Comment, p_LucroAbertas, p_lotBuy, p_lotSell, p_ProfitD, p_ProfitT;
   string Titulos[nTitulos]
     {
      "Comment",
      "Hab",
      "Positions_Profit",
      "Buy_Lot",
      "Sell_Lot",
      "Spread_Atual",
      "Profit_Today",
      "Profit",
      "Ok"
      //"Status"
     };

//YY+=Ysize+sY;

   for(int i=0; i<nTitulos-1; i++)
     {
      crTexto=Titulos[i];
      StringReplace(crTexto,"_"," ");
      InsereCampo("Titulo"+IntegerToString(i,2),crTexto,"",XX,Xsize,YY,Ysize,clr_pbackground,Font1);
      YY-=Ysize+sY;
     }
   crTexto=Titulos[nTitulos-1];
   InsereCampo("p_Aviso",crTexto,"",XX,Xsize*2,YY,Ysize,clr_pbackground,Font2);
   XX+=Xsize+sX;
   YY=Y1;
//YY+=Ysize+sY;

   for(int i=0; i<nTitulos-1; i++)
     {
      InsereCampo("p_"+Titulos[i],"0","",XX,Xsize,YY,Ysize,clr_pbackground,Font2);
      //Print("p_"+Titulos[i]);
      YY-=Ysize+sY;
     }
   YY-=Ysize+sY;
//XX=X1;
//InsereCampo("c_Status",Status,"",XX,Xsize*3,YY,Ysize,Fundo,LetraS);
   ObjectSetString(0,"p_Comment",OBJPROP_TEXT,p_Comment);

//XX+=Xsize+(sX*3);
//YY=Y1-(((Ysize+sY)*(nTitulos-2)));
//YY-=Ysize+sY;
   XX=X1;
//YY-=Ysize+sY;
   InsereBotao("BtnPanico","Close All","Close All!",XX-sX,Xsize*2+4*sX,YY,Ysize*2+sY,clr_ButtonClose,clr_BtFontClose);

//InicializaDados();
//AjustaPainel();
   AjustaHist();
//AjustaImediato();
   ChartRedraw(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AjustaHist()
  {
   LucroDia=0;
   LucroTotal=0;

   VerificaHistorico();//LucroDia,LucroTotal);     // OperacoesMkt

   p_Profit=DoubleToString(LucroTotal,2);
   p_Profit_Today=DoubleToString(LucroDia,2);

   AjustaImediato();
   if(LoteComprado+LoteVendido==0 && Prossegue)
     {
      ObjectGetInteger(0,"BtnPanico",OBJPROP_STATE,0);
      ChartRedraw(0);
     }
   if(!Prossegue)
     {
      ObjectGetInteger(0,"BtnPanico",OBJPROP_STATE,1);
      ChartRedraw(0);
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void VerificaHistorico()//double &LucroDia,double &LucroTotal)
  {
//if(VerificaOp)      Print(__FUNCTION__);
   LucroDia=0;
   LucroTotal=0;

   Agora();
//HistorySelect(0,TimeCurrent());
   HistorySelect(0,TimeCurrent());
//--- create objects
//string   name;
   uint     total = HistoryDealsTotal();
   ulong    ticket = 0;
//double   price;
   double   profit;
   datetime time;
   string   symbol;
   long     type;
//long     entry;
   long     magich;
   double volume;
//double volume;
//double SomaH = 0;
//int TicketDeste=0;
//double profit_totalO = 0;
//uint cTck = 0;
//double custos = 0;
//MqlDateTime mdt;
   double LoteTotal=0;
//ProfitTotal = 0;
//ProfitDia = 0;
//bool stands=false;
//int nVenc = 0,nPerd = 0,nTotal = 0;
//--- for all deals
   for(uint i = total - 1; i > 0; i--)
     {
      //--- try to get deals ticket
      if((ticket = HistoryDealGetTicket(i)) > 0)
        {
         //--- get deals properties
         //price = HistoryDealGetDouble(ticket,DEAL_PRICE);
         time  = (datetime)HistoryDealGetInteger(ticket,DEAL_TIME);
         volume = HistoryDealGetDouble(ticket,DEAL_VOLUME);
         symbol = HistoryDealGetString(ticket,DEAL_SYMBOL);
         type  = HistoryDealGetInteger(ticket,DEAL_TYPE);
         //entry = HistoryDealGetInteger(ticket,DEAL_ENTRY); //0=in,1=out
         profit = HistoryDealGetDouble(ticket,DEAL_PROFIT);
         magich = HistoryDealGetInteger(ticket,DEAL_MAGIC);
         //inout=HistoryDealGetInteger(ticket,DEAL_TYPE);
         //UltimoAgora=ticket;
         //Print("Ticket=",ticket,", Data:",time," - Magic: ",magich," - ",symbol," - profit: ",profit);

         if(magich == nMAGIC && symbol == m_symbol.Name())
           {
            LucroTotal+=profit;
            LoteTotal+=volume;
            //Print("Magic: ",magich," - ",symbol," - profit: ",profit);//,", time_a=",time_a);
            // TimeToStruct(time,mdt);
            //Print("dHoje=",dHoje,", StringSubstr((string)time,0,10)=",StringSubstr((string)time,0,10) );
            if(StringSubstr((string)time,0,10) == dHoje)
              {
               //if(VerificaOp)Print("Time = ",StringSubstr((string)time,0,10),", dHoje=",dHoje);
               LucroDia += profit;
               //Print("Lucro do dia=",LucroDia);
              }
            //if(profit > 0)               nVenc++;
            //if(profit < 0)               nPerd++;
            /*if(entry != 0)             //  nTotal++;
              {
               Print("entry=",entry,", profit=",profit);
              }*/
            //}//Dia
           }//magic
        }//ticket
     }//for

//Print("LucroAbertas=",LucroAbertas,", LucroDia=",LucroDia,", LucroTotal=",LucroTotal);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void InsereCampo(string NomeCampo,
                 string crTexto,
                 string ToolTip,
                 int XX,
                 int Xsize,
                 int YY,
                 int Ysize,
                 color clrFundo,
                 color clrFonte)
  {
   long Chart=0;
   ObjectCreate(Chart,NomeCampo, OBJ_EDIT,0,0,0,0,0);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_XDISTANCE, XX);// - (Xsizep));
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_YDISTANCE, YY);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_XSIZE,Xsize);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_YSIZE,Ysize);
   ObjectSetString(Chart,NomeCampo, OBJPROP_TEXT,crTexto);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_BGCOLOR,clrFundo);//COLOR_BTN);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_BORDER_COLOR,clrFundo);//COLOR_BTN);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_COLOR,clrFonte);//clrWhite);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_READONLY,1);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_ALIGN,ALIGN_RIGHT);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_ANCHOR,ANCHOR_BOTTOM);
   ObjectSetString(Chart,NomeCampo, OBJPROP_FONT,FONTE);
   ObjectSetString(Chart,NomeCampo, OBJPROP_TOOLTIP,ToolTip); //NomeCampo);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_FONTSIZE,TamFonte);
   ObjectSetInteger(Chart,NomeCampo,OBJPROP_CORNER,CORNER_LEFT_LOWER);            // set the chart corner

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void InsereBotao(string NomeCampo,
                 string crTexto,
                 string ToolTip,
                 int XX,
                 int Xsize,
                 int YY,
                 int Ysize,
                 color clrFundo,
                 color clrFonte)
  {
   long Chart=0;
   ObjectCreate(Chart,NomeCampo, OBJ_BUTTON,0,0,0,0,0);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_XDISTANCE, XX);// - (Xsizep));
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_YDISTANCE, YY);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_XSIZE,Xsize);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_YSIZE,Ysize);
   ObjectSetString(Chart,NomeCampo, OBJPROP_TEXT,crTexto);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_BGCOLOR,clrFundo);//COLOR_BTN);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_BORDER_COLOR,clrFundo);//COLOR_BTN);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_COLOR,clrFonte);//clrWhite);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_READONLY,1);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_ALIGN,ALIGN_RIGHT);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_ANCHOR,ANCHOR_BOTTOM);
   ObjectSetString(Chart,NomeCampo, OBJPROP_FONT,FONTE);
   ObjectSetString(Chart,NomeCampo, OBJPROP_TOOLTIP,ToolTip); //NomeCampo);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_FONTSIZE,TamFonte);
   ObjectSetInteger(Chart,NomeCampo,OBJPROP_CORNER,CORNER_LEFT_LOWER);            // set the chart corner

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Aguarde(string Texto="Loading...",string TTT="wait a moment")
  {


   PreparaFundoTela(0,0);

   int   Xsize =(int) MathCeil(150 * iFX),//120
         Ysize =(int) MathCeil(18 * iFX),
         sX    =(int) MathCeil(1 * iFX),
         sY    =(int) MathCeil(1 * iFX),
         X1    =(int) MathCeil(5 * iFX)+sX,
         Y1    =(int) MathCeil(5 * iFX)+(nTitulos+1)*(Ysize+sY)+Ysize*2+sY;

   InsereCampo("Aguardar",Texto,TTT,X1*5,Xsize,Y1,Ysize,clr_background,Font1);

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void InsereCampoTop(string NomeCampo,
                    string crTexto,
                    string ToolTip,
                    int XX,
                    int Xsize,
                    int YY,
                    int Ysize,
                    color clrFundo,
                    color clrFonte)
  {
   long Chart=0;
   ObjectCreate(Chart,NomeCampo, OBJ_EDIT,0,0,0,0,0);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_XDISTANCE, XX);// - (Xsizep));
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_YDISTANCE, YY);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_XSIZE,Xsize);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_YSIZE,Ysize);
   ObjectSetString(Chart,NomeCampo, OBJPROP_TEXT,crTexto);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_BGCOLOR,clrFundo);//COLOR_BTN);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_BORDER_COLOR,clrFundo);//COLOR_BTN);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_COLOR,clrFonte);//clrWhite);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_READONLY,1);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_ALIGN,ALIGN_LEFT);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_ANCHOR,ANCHOR_TOP);
   ObjectSetString(Chart,NomeCampo, OBJPROP_FONT,FONTE);
   ObjectSetString(Chart,NomeCampo, OBJPROP_TOOLTIP,ToolTip); //NomeCampo);
   ObjectSetInteger(Chart,NomeCampo, OBJPROP_FONTSIZE,TamFonte);
   ObjectSetInteger(Chart,NomeCampo,OBJPROP_CORNER,CORNER_LEFT_UPPER);            // set the chart corner

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AtualizaTela()
  {
   /*
    "Strategy",
    "Positions_Profit",
    "Buy_Lot",
    "Sell_Lot",
    "Profit_Today",
    "Profit"
   */
   /*
   ObjectSetString(0,"dASK",OBJPROP_TEXT,DoubleToString(PrecoAsk,_Digits));
   ObjectSetString(0,"dTPbuy",OBJPROP_TEXT,DoubleToString(TP_buy,_Digits));
   ObjectSetString(0,"dSLbuy",OBJPROP_TEXT,DoubleToString(SL_buy,_Digits));

   ObjectSetString(0,"dBID",OBJPROP_TEXT,DoubleToString(PrecoBid,_Digits));
   ObjectSetString(0,"dTPsell",OBJPROP_TEXT,DoubleToString(TP_sell,_Digits));
   ObjectSetString(0,"dSLsell",OBJPROP_TEXT,DoubleToString(SL_sell,_Digits));
   ObjectSetString(0,"dVolFin",OBJPROP_TEXT,DoubleToString(fLote,_Digits));
   ObjectSetString(0,"dVolLote",OBJPROP_TEXT,DoubleToString(dLote,dVol));
   ObjectSetString(0,"dVolLote",OBJPROP_TOOLTIP,TTMargem);
   */

   if(aTrend1==1)
      ObjectSetInteger(0,"tPasso1",OBJPROP_COLOR,clr_buyTrend);
   if(aTrend1==-1)
      ObjectSetInteger(0,"tPasso1",OBJPROP_COLOR,clr_sellTrend);

   if(Trend1==1)
      ObjectSetInteger(0,"tPasso2",OBJPROP_COLOR,clr_buyTrend);
   if(Trend1==-1)
      ObjectSetInteger(0,"tPasso2",OBJPROP_COLOR,clr_sellTrend);

   ObjectSetString(0,"vPasso3",OBJPROP_TEXT,DoubleToString(Ponto1,_Digits)+";"+DoubleToString(Ponto2,_Digits));
   ObjectSetString(0,"vPasso4",OBJPROP_TEXT,ValorPasso4);
   ObjectSetString(0,"vPasso5",OBJPROP_TEXT,ValorPasso5);
   ObjectSetString(0,"vPasso6",OBJPROP_TEXT,ValorPasso6);
   ObjectSetString(0,"vPasso7",OBJPROP_TEXT,ValorPasso7);
   if(Trend1==1)
      ObjectSetString(0,"vPasso8",OBJPROP_TEXT,DoubleToString(PrecoAberturaBuy0,_Digits));
   if(Trend1==-1)
      ObjectSetString(0,"vPasso8",OBJPROP_TEXT,DoubleToString(PrecoAberturaSell0,_Digits));
//InsereCampo("vPasso3",crTexto,"",XX+Xsize+sX,Xsize,YY,Ysize,clr_pbackground,Font1);

   if(funciona && inicio && Prossegue && TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
      p_Habilitado="true";
   else
      p_Habilitado="false";

//Print("p_Profit_Today=",p_Profit_Today);
//if(ID_Ordens>=0){
//ObjectSetString(0,"p_Comment",OBJPROP_TEXT,p_Comment);
   ObjectSetString(0,"p_Hab",OBJPROP_TEXT,p_Habilitado);
   ObjectSetString(0,"p_Positions_Profit",OBJPROP_TEXT,p_Positions_Profit);
   ObjectSetString(0,"p_Buy_Lot",OBJPROP_TEXT,p_Buy_Lot);
   ObjectSetString(0,"p_Sell_Lot",OBJPROP_TEXT,p_Sell_Lot);
   ObjectSetString(0,"p_Spread_Atual",OBJPROP_TEXT,DoubleToString(ASK-BID,_Digits));
   ObjectSetString(0,"p_Profit_Today",OBJPROP_TEXT,p_Profit_Today);
   ObjectSetString(0,"p_Profit",OBJPROP_TEXT,p_Profit);
   ObjectSetString(0,"p_Aviso",OBJPROP_TEXT,Recado);
  }

//+------------------------------------------------------------------+
//| Money Maker                                                      |
//+------------------------------------------------------------------+
bool HaveMoney=true;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CheckMoneyForTrade(string symb,ENUM_ORDER_TYPE type,double Lots)
  {

   if(!iConferirMargem)
      return true;
//--- obtemos o preço de abertura
   MqlTick mqltick;
   SymbolInfoTick(symb,mqltick);
   double price=mqltick.ask;

   if(type==ORDER_TYPE_SELL)
      price=mqltick.bid;
//--- valores da margem necessária e livre
   double margin,free_margin=AccountInfoDouble(ACCOUNT_MARGIN_FREE);
//--- chamamos a função de verificação
   if(!OrderCalcMargin(type,symb,Lots,price,margin))
     {
      //--- algo deu errado, informamos e retornamos false
      Print("Error in ",__FUNCTION__,", Cod. ",GetLastError());
      return(false);
     }

//--- se não houver fundos suficientes para realizar a operação
   if(margin>free_margin)
     {
      //--- informamos sobre o erro e retornamos false

      if(HaveMoney)
        {

         Print("Not enough money for ",EnumToString(type)," ",Lots," ",symb,".");//," ",getErrorDesc(GetLastError()));
         HaveMoney=false;
        }
      return(false);
     }
//--- a verificação foi realizada com sucesso
   if(!HaveMoney)
      HaveMoney=true;
   return(true);
  }
//+------------------------------------------------------------------+
