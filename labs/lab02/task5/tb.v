module tb;

  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;
  wire [3:0] t_result;

  integer errors;

  alu UUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  initial begin
    errors = 0;

    t_a  = 4'd5;
    t_b  = 4'd3;
    t_op = 1'b0;
    #1;

    if (t_result !== 4'd8) begin
      $display("FAIL: add 5 + 3: result=%b expected=1000",
               t_result);
      errors = errors + 1;
    end

    t_op = 1'b1;
    #1;

    if (t_result !== 4'd2) begin
      $display("FAIL: op-only change, 5 - 3: result=%b expected=0010",
               t_result);
      errors = errors + 1;
    end

    t_b = 4'd2;
    #1;

    if (t_result !== 4'd3) begin
      $display("FAIL: subtract 5 - 2: result=%b expected=0011",
               t_result);
      errors = errors + 1;
    end

    t_a = 4'd9;
    t_b = 4'd4;
    #1;

    if (t_result !== 4'd5) begin
      $display("FAIL: subtract 9 - 4: result=%b expected=0101",
               t_result);
      errors = errors + 1;
    end

    if (errors == 0)
      $display("PASS: all tests passed.");
    else
      $display("FAIL: %0d error(s) found.", errors);

    $finish;
  end

endmodule