ALizaveta Mishkinitse
%Redes de Neuronas Artificiales
%Curso 2017/18

function adeline

%Implementación de ADALINE (Adaptive Linear Element)

    %Número de ciclos de entrenamiento y la tasa de aprendizaje
    num_cycles = 1000; 
    tasa = 0.001;
   
    %Conjunto de entrenamiento
    training = csvread('Train.csv');
    train_x = training(:, 1:end-1);
    train_x = horzcat (train_x, ones(size(train_x,1),1));
    train_y = training(:, end);
    
    %Conjunto de validación
    validation = csvread('Validacion.csv');
    valid_x = validation(:, 1:end-1);
    valid_x = horzcat (valid_x, ones(size(valid_x,1),1));
    valid_y = validation(:, end);
    
    %Conjunto de test  
    testing = csvread('Test.csv');
    test_x = testing(:, 1:end-1);
    test_x = horzcat (test_x, ones(size(test_x,1),1));   
    test_y_norm = testing(:, end);
    test_y= csvread('Test_original.csv');
        
    %Inicialización aleatoria de los pesos
    w = rand(size(train_x,2),1);
    
    %Creación de fichero para guardar los errores de entrenamiento y
    %validación
    filename = 'errorAdaline.xlsx';
    file_data = {'Ciclo' 'Error de entrenamiento' 'Error de validación'};
    
   cycle = 1;
   while cycle<=num_cycles
       
   %Ciclo de entrenamiento
    for i = 1:size(train_x,1)
        out_y = train_x(i,:)*w;
        var_w = tasa*(train_y(i)-out_y)*train_x(i,:).';
        w = w + var_w;
    end 
   
    %Cálculo error de entrenamiento
    out_train = train_x*w;
    training_error = (train_y - out_train).^2;
    training_error = (sum(training_error,1))/size(train_x,1);
    
    %Cálculo error de validación
    out_valid = valid_x*w;
    validation_error = (valid_y - out_valid).^2;
    validation_error = sum(validation_error,1)/size(valid_x,1);
    
    %Salida por pantalla de errores
    %x = ['Error de entrenamiento: ', num2str(training_error), '   Error de validación: ', num2str(validation_error)];
    %display(x) 
    
    file_data (cycle+1, :)  = {cycle training_error validation_error};
    cycle = cycle+1;   
   end
   
   %Escritura de errores en el fichero de salida
   xlswrite(filename,file_data);
   
   %Cálculo de la salida y error normalizado de test
   out_test = test_x*w;
   testing_error_norm = (test_y_norm - out_test).^2;
   testing_error_norm = sum(testing_error_norm,1)/size(test_y_norm,1);
   
   %Desnormalización de la salida del test
   desnorm = csvread('ValoresParaDesnormalizar.csv');
   max_testing = desnorm (1);
   min_testing = desnorm (2);
   out_test = (max_testing-min_testing)*out_test+min_testing;
   testing_error = (test_y - out_test).^2;
   testing_error = sum(testing_error,1)/size(test_y,1);
   
   %Escritura de los pesos finales, el umbral y errores de test en el
   %fichero de salida
    fid= fopen('ficheroSalidaAdaline.txt','w');
    fprintf(fid, [ 'Pesos finales: ' '\n']);
    fprintf(fid, '%f \n', w(1:end-1,1)');
    fprintf(fid, '%s\r\n',' ');
    fprintf(fid, [ 'Umbral final: ' '\n']);
    fprintf(fid, '%f \n', w(end,1)');
    fprintf(fid, '%s\r\n',' ');
    fprintf(fid, [ 'Error de test normalizado: ' '\n']);
    fprintf(fid, '%f \n', testing_error_norm');
    fprintf(fid, '%s\r\n',' ');
    fprintf(fid, [ 'Error de test: ' '\n']);
    fprintf(fid, '%f \n', testing_error');
    fclose(fid);
   
   
   filename = 'testAdaline.xlsx';
   file_data = {'Salida obtenida' 'Salida esperada'};
      for i = 2:size(test_y,1)
       file_data(i,:) = {out_test(i) test_y(i)};
      end
   xlswrite(filename,file_data);
end

