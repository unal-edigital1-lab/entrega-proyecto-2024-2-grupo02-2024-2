module MaquinaEstados_TB;

    // Entradas
    reg clk;
    reg [2:0] humedad;
    reg [2:0] nutricion;
    reg [2:0] energia;
    reg [2:0] mantenimiento;
    reg [2:0] podado;
    reg reposando;
    
    // Salida
    wire [3:0] estado;
    
    // Instanciar el módulo bajo prueba
    MaquinaEstados dut (
        .clk(clk),
        .humedad(humedad),
        .nutricion(nutricion),
        .energia(energia),
        .mantenimiento(mantenimiento),
        .podado(podado),
        .reposando(reposando),
        .estado(estado)
    );
    
    // Generar reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        // Inicializar entradas
        humedad = 7;
        nutricion = 7;
        energia = 7;
        mantenimiento = 7;
        podado = 7;
        reposando = 0;
        
        #10;
        
        // Test 1: Estado DORMIDA (reposando=1)
        reposando = 1;
        #10;
        $display("Test 1: reposando=1 -> Estado = %b (DORMIDA)", estado);
        
        // Test 2: Estado DESOLADA (enfermo >= 3)
        reposando = 0;
        energia = 2;    // <3
        nutricion = 2;  // <3
        humedad = 2;    // <3
        podado = 3;     // >=3
        mantenimiento = 3; // >=3
        #10;
        $display("Test 2: enfermo >=3 -> Estado = %b (DESOLADA)", estado);
        
        // Test 3: Estado MUERTE (marchita >= 2)
        energia = 4;    // <5
        nutricion = 4;  // <5
        humedad = 5;    // >=5
        podado = 5;     // >=5
        mantenimiento = 5; // >=5
        #10;
        $display("Test 3: marchita >=2 -> Estado = %b (MUERTE)", estado);
        
        // Test 4: Estado DESNUTRIDA (nutricion <5)
        nutricion = 4;  // <5
        energia = 5;    // >=5
        humedad = 5;    // >=5
        podado = 5;     // >=5
        mantenimiento = 5; // >=5
        #10;
        $display("Test 4: nutricion <5 -> Estado = %b (DESNUTRIDA)", estado);
        
        // Test 5: Estado DESHIDRATADA (humedad <5)
        nutricion = 5;  // >=5
        humedad = 4;    // <5
        #10;
        $display("Test 5: humedad <5 -> Estado = %b (DESHIDRATADA)", estado);
        
        // Test 6: Estado REMONTADA (podado <5)
        humedad = 5;    // >=5
        podado = 4;     // <5
        #10;
        $display("Test 6: podado <5 -> Estado = %b (REMONTADA)", estado);
        
        // Test 7: Estado DESCUIDADA (mantenimiento <5)
        podado = 5;     // >=5
        mantenimiento = 4; // <5
        #10;
        $display("Test 7: mantenimiento <5 -> Estado = %b (DESCUIDADA)", estado);
        
        // Test 8: Estado INSOLADO (energia <5)
        mantenimiento = 5; // >=5
        energia = 4;    // <5
        #10;
        $display("Test 8: energia <5 -> Estado = %b (INSOLADO)", estado);
        
        // Test 9: Estado EXCELENTE (suma total =35)
        energia = 7;
        nutricion = 7;
        humedad = 7;
        podado = 7;
        mantenimiento = 7;
        #10;
        $display("Test 9: suma=35 -> Estado = %b (EXCELENTE)", estado);
        
        // Test 10: Estado BIEN (condiciones normales)
        energia = 5;
        nutricion = 5;
        humedad = 5;
        podado = 5;
        mantenimiento = 5;
        #10;
        $display("Test 10: condiciones normales -> Estado = %b (BIEN)", estado);
        
        // Finalizar simulación
        #10;
        $finish;
    end
    
endmodule